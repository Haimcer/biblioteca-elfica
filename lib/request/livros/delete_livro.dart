import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';


class DeleteLivroRequest {
  BuildContext context;
  DeleteLivroRequest(this.context);

  Future<bool> deleteLivro(String livroId, {bool renovarToken = true}) async {
    final userIds = Provider.of<UserIds>(context, listen: false);

    try {
      final url = Uri.parse('${GlobalsVars().urlAPI}/livros/$livroId');

      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );

      if (response.statusCode == 204) {
        return true;
      } else if (response.statusCode == 403 && renovarToken) {
        final novoToken = await userIds.setRenovaToken();
        if (novoToken != null) {
          userIds.setTokenAPI(novoToken);
          return await deleteLivro(livroId, renovarToken: false);
        }
      }

      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro ao excluir livro\n${response.body}\nTente novamente mais tarde.",
      );
    } catch (e) {
      print("Erro ao excluir livro: $e");
      GlobalsAlert(context).alertWarning(
        context,
        text: "Erro ao excluir livro, tente novamente.",
      );
    }

    return false;
  }
}
