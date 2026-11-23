import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PutEditarCategoriaRequest {
  final BuildContext context;
  PutEditarCategoriaRequest(this.context);

  Future<Map<String, dynamic>?> editarCategoria({
    required String categoriaId,
    required String novoNome,
    var novoToken,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.put(
        Uri.parse('${GlobalsVars().urlAPI}/categorias/$categoriaId'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "nome": novoNome,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return await editarCategoria(
          categoriaId: categoriaId,
          novoNome: novoNome,
          novoToken: novoTokenAux,
        );
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "${response.body}\nErro ao editar categoria.",
      );
    } catch (e) {
      print("Erro ao editar categoria: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao editar categoria.",
      );
    }

    return null;
  }
}
