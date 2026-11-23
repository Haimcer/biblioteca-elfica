import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';


class DeleteUsuarioRequest {
  final BuildContext context;
  DeleteUsuarioRequest(this.context);

  Future<bool> deleteUsuario({
    required String usuarioId,
    bool tentarRenovarToken = true,
  }) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final url = Uri.parse('${GlobalsVars().urlAPI}/usuarios/$usuarioId');

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );

      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 403 && tentarRenovarToken) {
        final novoToken = await userIds.setRenovaToken();
        if (novoToken != null) {
          userIds.setTokenAPI(novoToken);
          return await deleteUsuario(
            usuarioId: usuarioId,
            tentarRenovarToken: false,
          );
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro ao excluir usuário.\n${response.body}\nTente novamente.",
      );
    } catch (e) {
      print("Erro ao excluir usuário: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao excluir usuário.",
      );
    }

    return false;
  }
}
