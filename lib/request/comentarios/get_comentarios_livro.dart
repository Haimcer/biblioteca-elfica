import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leitor_ebooks/globals/globlas_alert.dart';
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../modals/comentario.dart';

class GetComentariosPorLivroRequest {
  final BuildContext context;
  GetComentariosPorLivroRequest(this.context);

  Future<List<ComentarioModel>?> getComentarios(String livroId, {var novoToken}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.get(
        Uri.parse('${GlobalsVars().urlAPI}/comentarios/$livroId'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = json.decode(response.body);
        return (body as List)
            .map((json) => ComentarioModel.fromJson(json))
            .toList();
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return await getComentarios(livroId, novoToken: novoTokenAux);
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "${response.body}\nErro ao buscar comentários.",
      );
    } catch (e) {
      print("Erro ao buscar comentários: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao buscar comentários.",
      );
    }

    return null;
  }
}
