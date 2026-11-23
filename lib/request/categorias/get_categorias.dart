import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';
import '../../modals/categoria.dart';

class GetTodasCategoriasRequest {
  final BuildContext context;
  GetTodasCategoriasRequest(this.context);

  Future<List<CategoriaModel>?> getCategorias({var novoToken}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.get(
        Uri.parse('${GlobalsVars().urlAPI}/categorias'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = json.decode(response.body);
        return (body as List)
            .map((json) => CategoriaModel.fromJson(json))
            .toList();
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        if (novoTokenAux != null) {
          userIds.setTokenAPI(novoTokenAux);
          return await getCategorias(novoToken: novoTokenAux);
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "${response.body}\nErro ao buscar categorias",
      );
    } catch (e) {
      print("Erro ao buscar categorias: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao buscar categorias",
      );
    }

    return null;
  }
}
