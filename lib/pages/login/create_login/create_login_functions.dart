import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leitor_ebooks/modals/usuario_model.dart';
import 'package:leitor_ebooks/pages/dashboard/dashboard_page.dart';

import '../../../controllers/user_ids.dart';
import '../../../controllers/user_infos.dart';
import '../../../globals/globals_functions.dart';
import '../../../globals/globlas_alert.dart';
import '../../../request/usuarios/post_criar_usuario.dart';

class CreateLoginFunctions {
  BuildContext context;
  CreateLoginFunctions(this.context);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();
  TextEditingController controllerConfSenha = TextEditingController();

  Future createLoginFunctionsPrincipal(BuildContext contextAux) async {}

  Future loginCreateAccount(
      BuildContext contextAux, UserIds userIds, UserInfos userInfos) async {
    String emailValido = controllerEmail.text.replaceAll(' ', '');

    if (!GlobalsFunctions().validaEmail(emailValido)) {
      GlobalsAlert(contextAux).alertWarning(contextAux, text: "Email inválido");
      return;
    }

    if (controllerSenha.text.length < 8) {
      GlobalsAlert(contextAux).alertWarning(contextAux,
          text: "Senha deve ter mais que 8 caracteres");
      return;
    }

    if (controllerSenha.text != controllerConfSenha.text) {
      GlobalsAlert(contextAux)
          .alertWarning(contextAux, text: "Senhas devem ser iguais");
      return;
    }

    if (!await GlobalsFunctions().verificaConexao()) {
      try {
        await _auth.createUserWithEmailAndPassword(
          email: emailValido,
          password: controllerSenha.text,
        );

        final idToken = await _auth.currentUser?.getIdToken();
        print("_idToken: $idToken");
        final uidUser = _auth.currentUser?.uid;
        userIds.setIds(idToken, uidUser);
        if (idToken != null && uidUser != null) {
          var dadosUser = await PostCriarOuAtualizarUsuarioRequest(contextAux)
              .syncUsuarioFirebase();

          if (dadosUser != null) {
            userInfos.setUsuario(UsuarioModel.fromJson(dadosUser));
          } else {
            GlobalsAlert(contextAux).alertError(contextAux,
                text:
                    'Erro ao logar com Google ou usuário inválido. Tente novamente mais tarde');
            return;
          }
          await limpaControllers();
          Navigator.pushAndRemoveUntil(
            contextAux,
            MaterialPageRoute(builder: (_) => DashboardPage()),
            (route) => false,
          );
        }
        GlobalsAlert(contextAux).alertError(contextAux,
            text:
                'Erro ao logar com Google ou usuário inválido. Tente novamente mais tarde');
        return;
      } catch (_err) {
        print('deu erro ein');
        print(_err);
        GlobalsAlert(contextAux)
            .alertWarning(contextAux, text: "Email já cadastrado ou inválido");
      }
    } else {
      GlobalsAlert(contextAux).alertInternet(contextAux);
    }
  }

  Future limpaControllers() async {
    controllerEmail.clear();
    controllerSenha.clear();
    controllerConfSenha.clear();
  }
}
