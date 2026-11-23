import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PostToggleSeguirPerfilRequest {
  final BuildContext context;
  PostToggleSeguirPerfilRequest(this.context);

  Future<bool> toggleSeguirPerfil(String perfilId, bool isUsuario) async {
    try {
      final userIds = Provider.of<UserIds>(context, listen: false);
      String tipo = isUsuario ? 'usuario' : 'escritor';
      final response = await http.post(
        Uri.parse(
            '${GlobalsVars().urlAPI}/seguidores/perfil/$perfilId/$tipo/seguir'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
          'Content-Type': 'application/json',
        },
      );
      return response.statusCode == 200;
    } catch (e) {
      GlobalsAlert(context).alertWarning(context, text: e.toString());
      return false;
    }
  }
}
