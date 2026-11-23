import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PutEditarComentarioRequest {
  final BuildContext context;
  PutEditarComentarioRequest(this.context);

  Future<Map<String, dynamic>?> editarComentario({
    required String comentarioId,
    required String novaMensagem,
    var novoToken,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.put(
        Uri.parse('${GlobalsVars().urlAPI}/comentarios/$comentarioId'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'mensagem': novaMensagem,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return await editarComentario(
          comentarioId: comentarioId,
          novaMensagem: novaMensagem,
          novoToken: novoTokenAux,
        );
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "${response.body}\nErro ao editar comentário.",
      );
    } catch (e) {
      print("Erro ao editar comentário: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao editar comentário.",
      );
    }

    return null;
  }
}
