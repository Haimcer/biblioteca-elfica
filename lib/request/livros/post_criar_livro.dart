import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leitor_ebooks/request/ultils/country_detector.dart';
import 'package:provider/provider.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PostCriarLivroRequest {
  final BuildContext context;
  PostCriarLivroRequest(this.context);

  Future<Map<String, dynamic>?> criarLivro({
    required String title,
    required String description,
    required String categoryId,
    required String idioma,
    bool isPremium = false,
    required bool isFree,
    int? precoCentavos,                // exigir se isFree == false
    required Uint8List capaBytes,
    required String capaFileName,
    required Uint8List pdfBytes,
    required String pdfFileName,
    String? novoToken,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);
    final regiao = await detectarRegiaoPadrao();

    if (!isFree && (precoCentavos == null || precoCentavos <= 0)) {
      GlobalsAlert(context).alertWarning(
        context,
        text: 'Preço é obrigatório para livros pagos.',
      );
      return null;
    }

    try {
      final uri = Uri.parse('${GlobalsVars().urlAPI}/livros');
      final request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'Bearer ${userIds.tokenAPI}'
        ..fields['title']        = title
        ..fields['description']  = description
        ..fields['category_id']  = categoryId
        ..fields['is_premium']   = isPremium.toString()
        ..fields['regiao']       = regiao
        ..fields['idioma']       = idioma
        ..fields['is_free']      = isFree.toString();

      if (!isFree) {
        request.fields['preco'] = precoCentavos!.toString();
      }

      final mimeCapa = lookupMimeType(capaFileName) ?? 'image/jpeg';
      final mimePdf  = lookupMimeType(pdfFileName)  ?? 'application/pdf';

      request.files
        ..add(http.MultipartFile.fromBytes(
          'capa',
          capaBytes,
          filename: capaFileName,
          contentType: MediaType.parse(mimeCapa),
        ))
        ..add(http.MultipartFile.fromBytes(
          'pdf',
          pdfBytes,
          filename: pdfFileName,
          contentType: MediaType.parse(mimePdf),
        ));

      final response = await request.send();
      final body     = await response.stream.bytesToString();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(body) as Map<String, dynamic>;
      }

      // token expirado → tenta renovar uma única vez
      if (response.statusCode == 403 && novoToken == null) {
        final refreshed = await userIds.setRenovaToken();
        if (refreshed != null) {
          userIds.setTokenAPI(refreshed);
          return criarLivro(
            title: title,
            description: description,
            categoryId: categoryId,
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
        text: '$body\nErro ao criar livro.',
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

