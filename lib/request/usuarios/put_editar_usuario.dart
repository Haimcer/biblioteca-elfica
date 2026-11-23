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

class PutEditarUsuarioRequest {
  final BuildContext context;
  PutEditarUsuarioRequest(this.context);

  Future<Map<String, dynamic>?> editarUsuario({
    required String usuarioId,
    String? nomeUsuario,
    Uint8List? imagem,
    String? imagemFileName,
    var novoToken,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      var request = http.MultipartRequest(
        'PUT',
        Uri.parse('${GlobalsVars().urlAPI}/usuarios/$usuarioId'),
      );

      request.headers.addAll({
        'Authorization': 'Bearer ${userIds.tokenAPI}',
      });

      if (nomeUsuario != null && nomeUsuario.trim().isNotEmpty) {
        request.fields['nome_usuario'] = nomeUsuario;
      }

      if (imagem != null && imagemFileName != null) {
        final mime = lookupMimeType(imagemFileName) ?? 'image/jpeg';
        request.files.add(http.MultipartFile.fromBytes(
          'foto',
          imagem,
          filename: imagemFileName,
          contentType: MediaType.parse(mime),
        ));
      }

      final response = await request.send();
      final resultBody = await response.stream.bytesToString();

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(resultBody);
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return await editarUsuario(
          usuarioId: usuarioId,
          nomeUsuario: nomeUsuario,
          imagem: imagem,
          imagemFileName: imagemFileName,
          novoToken: novoTokenAux,
        );
      } else {
        GlobalsAlert(context).alertWarning(
          context,
          text: "$resultBody\nErro ao editar usuário.",
        );
      }
    } catch (e) {
      print("Erro ao editar usuário: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro ao editar usuário. Tente novamente.",
      );
    }

    return null;
  }
}
