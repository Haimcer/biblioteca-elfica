import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class DeleteComentarioRequest {
  final BuildContext context;
  DeleteComentarioRequest(this.context);

  Future<bool> deletarComentario(String comentarioId, {var novoToken}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.delete(
        Uri.parse('${GlobalsVars().urlAPI}/comentarios/$comentarioId'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );

      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return await deletarComentario(comentarioId, novoToken: novoTokenAux);
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "${response.body}\nErro ao excluir comentário.",
      );
    } catch (e) {
      print("Erro ao excluir comentário: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao excluir comentário.",
      );
    }

    return false;
  }
}
