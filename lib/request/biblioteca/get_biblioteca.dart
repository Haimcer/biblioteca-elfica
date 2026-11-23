import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leitor_ebooks/controllers/user_ids.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/globlas_alert.dart';
import 'package:provider/provider.dart';
import 'dart:convert';

class GetBibliotecaRequest {
  final BuildContext context;
  GetBibliotecaRequest(this.context);

  Future<Map<String, dynamic>?> listarBiblioteca() async {
    try {
      final userIds = Provider.of<UserIds>(context, listen: false);
      final response = await http.get(
        Uri.parse('${GlobalsVars().urlAPI}/biblioteca/'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        GlobalsAlert(context).alertWarning(context, text: 'Erro ao listar biblioteca');
      }
    } catch (e) {
      GlobalsAlert(context).alertWarning(context, text: e.toString());
    }
    return null;
  }
}
