import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class DeleteCategoriaRequest {
  final BuildContext context;
  DeleteCategoriaRequest(this.context);

  Future<bool> deletarCategoria(String categoriaId, {var novoToken}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final response = await http.delete(
        Uri.parse('${GlobalsVars().urlAPI}/categorias/$categoriaId'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );

      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 403 && novoToken == null) {
        final novoTokenAux = await userIds.setRenovaToken();
        userIds.setTokenAPI(novoTokenAux);
        return await deletarCategoria(categoriaId, novoToken: novoTokenAux);
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "${response.body}\nErro ao excluir categoria.",
      );
    } catch (e) {
      print("Erro ao excluir categoria: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro inesperado ao excluir categoria.",
      );
    }

    return false;
  }
}
