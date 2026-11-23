import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class GetVerificarNomeDisponivelRequest {
  final BuildContext context;
  GetVerificarNomeDisponivelRequest(this.context);

  Future<bool> verificarDisponibilidade(String nome, {bool renovarToken = true}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final url = Uri.parse('${GlobalsVars().urlAPI}/usuarios/disponivel/$nome');

      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['disponivel'] == true;
      } else if (response.statusCode == 403 && renovarToken) {
        final novoToken = await userIds.setRenovaToken();
        if (novoToken != null) {
          userIds.setTokenAPI(novoToken);
          return await verificarDisponibilidade(nome, renovarToken: false);
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro ao verificar nome.\n${response.body}",
      );
    } catch (e) {
      print("Erro ao verificar nome de usuário: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao verificar nome.",
      );
    }

    return false;
  }
}
