import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../controllers/user_ids.dart';
import '../../globals/globals_vars.dart';
import '../../globals/globlas_alert.dart';

class PostAddLivroBibliotecaRequest {
  final BuildContext context;
  PostAddLivroBibliotecaRequest(this.context);

  Future<bool> adicionarLivro(String livroId) async {
    try {
      final userIds = Provider.of<UserIds>(context, listen: false);
      final response = await http.post(
        Uri.parse('${GlobalsVars().urlAPI}/biblioteca/$livroId'),
        headers: {
          'Authorization': 'Bearer ${userIds.tokenAPI}',
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        GlobalsAlert(context)
            .alertWarning(context, text: 'Erro ao adicionar livro');
      }
    } catch (e) {
      GlobalsAlert(context).alertWarning(context, text: e.toString());
    }
    return false;
  }
}
