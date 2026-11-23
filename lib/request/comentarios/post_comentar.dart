import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PostComentarLivroRequest {
  final BuildContext context;
  PostComentarLivroRequest(this.context);

  Future<Map<String, dynamic>?> comentarLivro({
    required String livroId,
    required String mensagem,
    var novoToken,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.post(
        Uri.parse('${GlobalsVars().urlAPI}/comentarios/$livroId'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'mensagem': mensagem,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return await comentarLivro(
          livroId: livroId,
          mensagem: mensagem,
          novoToken: novoTokenAux,
        );
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "${response.body}\nErro ao enviar comentário.",
      );
    } catch (e) {
      print("Erro ao comentar livro: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao comentar livro.",
      );
    }

    return null;
  }
}
