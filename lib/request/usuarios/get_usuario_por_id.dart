import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';


class GetUsuarioPorIdRequest {
  final BuildContext context;
  GetUsuarioPorIdRequest(this.context);

  Future<Map<String, dynamic>?> getUsuario(String usuarioId, {bool renovarToken = true}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final url = Uri.parse('${GlobalsVars().urlAPI}/usuarios/$usuarioId');

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
          return await getUsuario(usuarioId, renovarToken: false);
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro ao buscar usuário\n${response.body}\nTente novamente.",
      );
    } catch (e) {
      print("Erro ao buscar usuário: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao buscar usuário.",
      );
    }

    return null;
  }
}
