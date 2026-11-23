import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globlas_alert.dart';

class PostToggleCurtidaPerfilRequest {
  final BuildContext context;
  PostToggleCurtidaPerfilRequest(this.context);

  Future<bool> toggleCurtidaPerfil(String perfilId, bool isUsuario) async {
    try {
      final userIds = Provider.of<UserIds>(context, listen: false);
      String tipo = isUsuario ? 'usuario' : 'escritor';
      final response = await http.post(
        Uri.parse('${GlobalsVars().urlAPI}/curtida-perfil/perfil/$perfilId/$tipo/toggle'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      GlobalsAlert(context).alertWarning(context, text: e.toString());
      return false;
    }
  }
}
