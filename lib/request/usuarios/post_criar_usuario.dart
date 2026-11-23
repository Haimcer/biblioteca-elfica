import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PostCriarOuAtualizarUsuarioRequest {
  final BuildContext context;
  PostCriarOuAtualizarUsuarioRequest(this.context);

  Future<Map<String, dynamic>?> syncUsuarioFirebase({bool renovarToken = true}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final url = Uri.parse('${GlobalsVars().urlAPI}/usuarios/me');

      final response = await http.post(
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
          return await syncUsuarioFirebase(renovarToken: false);
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro ao sincronizar usuário com Firebase.\n${response.body}",
      );
    } catch (e) {
      print("Erro ao sincronizar usuário com Firebase: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao sincronizar usuário.",
      );
    }

    return null;
  }
}
