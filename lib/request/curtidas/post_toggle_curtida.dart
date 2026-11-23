import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PostToggleCurtida {
  final BuildContext context;
  PostToggleCurtida(this.context);

  Future<bool> toggleCurtida(String livroId, {String? novoToken}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.post(
        Uri.parse('${GlobalsVars().urlAPI}/curtidas/$livroId'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
          'Content-Type': 'application/json',
        },
      );

      final body = json.decode(response.body);
      print('📥 [Curtida] Status: ${response.statusCode} | Body: $body');

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return toggleCurtida(livroId, novoToken: novoTokenAux);
      } else {
        GlobalsAlert(context).alertWarning(
          context,
          text: "${body['message'] ?? 'Erro ao curtir/descurtir.'}",
        );
      }
    } catch (e) {
      print('❌ Erro inesperado ao curtir/descurtir: $e');
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao curtir/descurtir. Tente novamente.",
      );
    }

    return false;
  }
}
