import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:provider/provider.dart';

import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PutEditarLivroRequest {
  final BuildContext context;
  PutEditarLivroRequest(this.context);

  Future<Map<String, dynamic>?> editarLivro({
    required String livroId,

    // ─── campos textuais (opcionais) ───────────────────────────
    String? title,
    String? description,
    String? categoryId,
    String? regiao,
    String? idioma,
    bool?   isPremium,
    bool?   isFree,
    int?    precoCentavos, // obrigatório se isFree == false

    // ─── arquivos (opcionais) ─────────────────────────────────
    Uint8List? capaBytes,
    String?    capaFileName,
    Uint8List? pdfBytes,
    String?    pdfFileName,

    String? novoToken,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    // Validação mínima
    if (isFree == false && (precoCentavos == null || precoCentavos <= 0)) {
      GlobalsAlert(context).alertWarning(
        context,
        text: 'Preço é obrigatório para livros pagos.',
      );
      return null;
    }

    try {
      final uri = Uri.parse('${GlobalsVars().urlAPI}/livros/$livroId');
      final request = http.MultipartRequest('PUT', uri)
        ..headers['Authorization'] = 'Bearer ${userIds.tokenAPI}';

      /* ───── adiciona apenas campos que mudaram ───── */
      void addField(String key, String? value) {
        if (value != null && value.trim().isNotEmpty) {
          request.fields[key] = value;
        }
      }

      addField('title',         title);
      addField('description',   description);
      addField('category_id',   categoryId);
      addField('regiao',        regiao);
      addField('idioma',        idioma);
      if (isPremium != null)   request.fields['is_premium'] = isPremium.toString();
      if (isFree   != null)    request.fields['is_free']    = isFree.toString();
      if (precoCentavos != null) request.fields['preco']    = precoCentavos.toString();

      /* ───── arquivos (se enviados) ───── */
      if (capaBytes != null && capaFileName != null) {
        final mimeCapa = lookupMimeType(capaFileName) ?? 'image/jpeg';
        request.files.add(http.MultipartFile.fromBytes(
          'capa', capaBytes,
          filename: capaFileName,
          contentType: MediaType.parse(mimeCapa),
        ));
      }

      if (pdfBytes != null && pdfFileName != null) {
        final mimePdf = lookupMimeType(pdfFileName) ?? 'application/pdf';
        request.files.add(http.MultipartFile.fromBytes(
          'pdf', pdfBytes,
          filename: pdfFileName,
          contentType: MediaType.parse(mimePdf),
        ));
      }

      /* ───── envia ───── */
      final response = await request.send();
      final body     = await response.stream.bytesToString();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(body) as Map<String, dynamic>;
      }

      /* token expirado → renova uma vez */
      if (response.statusCode == 403 && novoToken == null) {
        final refreshed = await userIds.setRenovaToken();
        if (refreshed != null) {
          userIds.setTokenAPI(refreshed);
          return editarLivro(
            livroId: livroId,
            title: title,
            description: description,
            categoryId: categoryId,
            regiao: regiao,
            idioma: idioma,
            isPremium: isPremium,
            isFree: isFree,
            precoCentavos: precoCentavos,
            capaBytes: capaBytes,
            capaFileName: capaFileName,
            pdfBytes: pdfBytes,
            pdfFileName: pdfFileName,
            novoToken: refreshed,
          );
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: '$body\nErro ao editar livro.',
      );
    } catch (e) {
      GlobalsAlert(context).alertWarning(
        context,
        text: 'Erro inesperado: $e',
      );
    }
    return null;
  }
}
