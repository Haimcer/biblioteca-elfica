import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:leitor_ebooks/controllers/user_ids.dart';
import 'package:leitor_ebooks/controllers/user_infos.dart';
import 'package:leitor_ebooks/globals/globals_functions.dart';
import 'package:leitor_ebooks/globals/globlas_alert.dart';
import 'package:leitor_ebooks/modals/usuario_model.dart';
import 'package:leitor_ebooks/pages/dashboard/dashboard_page.dart';
import 'package:leitor_ebooks/request/usuarios/post_criar_usuario.dart';

class LoginPrincipalFunctions {
  BuildContext context;
  LoginPrincipalFunctions(this.context);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerSenha = TextEditingController();

  Future loginPrincipalFunctionsPrincipal(BuildContext contextAux) async {
    googleSignIn = GoogleSignIn(
      clientId:
          "1025096619766-i6ke7u6i65fb1107svllal1n96jaap7v.apps.googleusercontent.com");
  }

  Future loginGmail(contextAux, UserIds userIds, UserInfos userInfos) async {
    print('object');
    if (await GlobalsFunctions().verificaConexao()) {
      GlobalsAlert(contextAux).alertInternet(contextAux);
      return;
    }
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await _auth.signInWithCredential(credential);

      final _idToken = await _auth.currentUser?.getIdToken();
      final _uidUser = await _auth.currentUser?.uid;

      userIds.setIds(_idToken, _uidUser);
      if (_idToken != null && _uidUser != null) {
        var dadosUser = await PostCriarOuAtualizarUsuarioRequest(context)
            .syncUsuarioFirebase();
        if (dadosUser != null) {
          userInfos.setUsuario(UsuarioModel.fromJson(dadosUser));
        } else {
          GlobalsAlert(contextAux).alertError(contextAux,
              text:
                  'Erro ao logar ou usuário inválido. Tente novamente mais tarde');
          return;
        }
        await limpaControllers();
        Navigator.pushAndRemoveUntil(
          contextAux,
          MaterialPageRoute(builder: (_) => DashboardPage()),
          (route) => false,
        );
        return;
      }
      GlobalsAlert(contextAux).alertError(contextAux,
          text:
              'Erro ao logar ou usuário inválido. Tente novamente mais tarde');
      return;
    } catch (_err) {
      print(_err);
      GlobalsAlert(contextAux).alertError(contextAux,
          text: 'Erro ao logar com Google. Tente novamente mais tarde');
    }
  }

  //LOGIN COM EMAIL E SENHA
  Future logarEmailPass(contextAux, userIds, UserInfos userInfos) async {
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
    if (await GlobalsFunctions().verificaConexao()) {
      GlobalsAlert(contextAux).alertInternet(contextAux);
      return;
    }
    try {
      await _auth.signInWithEmailAndPassword(
        email: emailValido,
        password: controllerSenha.text,
      );

      final _idToken = await _auth.currentUser?.getIdToken();
      final _uidUser = await _auth.currentUser?.uid;
      log("_idToken: $_idToken");
      userIds.setIds(_idToken, _uidUser);
      if (_idToken != null && _uidUser != null) {
        var dadosUser = await PostCriarOuAtualizarUsuarioRequest(contextAux)
            .syncUsuarioFirebase();
        if (dadosUser != null) {
          userInfos.setUsuario(UsuarioModel.fromJson(dadosUser));
        } else {
          GlobalsAlert(contextAux).alertError(contextAux,
              text:
                  'Erro ao logar ou usuário inválido. Tente novamente mais tarde');
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
              'Erro ao logar ou usuário inválido. Tente novamente mais tarde');
      return;
    } catch (_err) {
      GlobalsAlert(contextAux).alertWarning(contextAux, text: "Login Inválido");
      return;
    }
  }

  Future limpaControllers() async {
    controllerEmail.clear();
    controllerSenha.clear();
  }
}
