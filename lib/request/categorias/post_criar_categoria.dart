import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PostCriarCategoriaRequest {
  final BuildContext context;
  PostCriarCategoriaRequest(this.context);

  Future<Map<String, dynamic>?> criarCategoria({
    required String nome,
    var novoToken,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.post(
        Uri.parse('${GlobalsVars().urlAPI}/categorias'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "nome": nome,
        }),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return await criarCategoria(nome: nome, novoToken: novoTokenAux);
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "${response.body}\nErro ao criar categoria.",
      );
    } catch (e) {
      print("Erro ao criar categoria: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao criar categoria.",
      );
    }

    return null;
  }
}
