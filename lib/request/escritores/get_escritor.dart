import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';
import 'dart:convert';

class GetEscritorRequest {
  final BuildContext context;
  GetEscritorRequest(this.context);

  Future<Map<String, dynamic>?> getEscritor(String usuarioId) async {
    try {
      final response = await http.get(
          Uri.parse('${GlobalsVars().urlAPI}/escritores/usuario/$usuarioId'));
      print(response.body);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        GlobalsAlert(context)
            .alertWarning(context, text: 'Erro ao buscar escritor');
      }
    } catch (e) {
      GlobalsAlert(context).alertWarning(context, text: e.toString());
    }
    return null;
  }
}
