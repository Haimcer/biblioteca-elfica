import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class GetLivrosRequest {
  BuildContext context;
  GetLivrosRequest(this.context);

  Future<List<dynamic>?> getLivros(
      {String? categoriaId, bool renovarToken = true}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final url = Uri.parse(
          '${GlobalsVars().urlAPI}/livros/${categoriaId ?? ''}/Brasil');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return json.decode(response.body);
      } else if (response.statusCode == 403 && renovarToken) {
        final novoToken = await userIds.setRenovaToken();
        if (novoToken != null) {
          userIds.setTokenAPI(novoToken);
          return await getLivros(categoriaId: categoriaId, renovarToken: false);
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text:
            "Erro ao buscar livros\n${response.body}\nTente novamente mais tarde.",
      );
    } catch (e) {
      print("Erro ao buscar livros: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro ao buscar livros, tente novamente.",
      );
    }

    return null;
  }
}
