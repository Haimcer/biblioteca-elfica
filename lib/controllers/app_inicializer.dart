import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leitor_ebooks/modals/usuario_model.dart';
import 'package:leitor_ebooks/pages/dashboard/dashboard_page.dart';
import 'package:leitor_ebooks/request/usuarios/post_criar_usuario.dart';
import '../controllers/user_ids.dart';
import '../controllers/user_infos.dart';
import '../pages/login/login_principal_page.dart';
import '../main.dart'; // Importa o navigatorKey

class AppInitializer {
  static Future<void> initialize(
    UserIds userIds,
    UserInfos userInfos,
  ) async {
    await _handleLoginFlow(userIds, userInfos);
  }

  /// **Gerencia o fluxo de login**
  static Future<void> _handleLoginFlow(
    UserIds userIds,
    UserInfos userInfos,
  ) async {
    final user = FirebaseAuth.instance;
    final context = navigatorKey.currentContext;
    if (context == null) {
      print("⚠️ Contexto nulo ao tentar autenticar usuário.");
      return;
    }

    try {
      final userData = await _authenticateUser(userIds, userInfos, context);
      if (userData == null) return;

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => DashboardPage()),
        (route) => false,
      );
    } catch (e) {
      print("❌ Erro ao gerenciar login: $e");
      user.signOut();
      _navigateTo(context, LoginPrincipalPage());
    }
  }

  /// **Autentica o Usuário e Retorna os Dados**
  static Future<Map<String, dynamic>?> _authenticateUser(
    UserIds userIds,
    UserInfos userInfos,
    BuildContext context,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _navigateTo(context, LoginPrincipalPage());
      return null;
    }

    final idToken = await user.getIdToken();
    final uid = user.uid;

    if (idToken == null || uid.isEmpty) {
      _navigateTo(context, LoginPrincipalPage());
      return null;
    }

    userIds.setIds(idToken, uid);

    final userData = await PostCriarOuAtualizarUsuarioRequest(context)
            .syncUsuarioFirebase();

    userIds.setTokenAPI(idToken);
    if (userData != null) {
        userInfos.setUsuario(UsuarioModel.fromJson(userData));
    }
    return userData;
  }

  /// **Gerencia a Navegação**
  static void _navigateTo(BuildContext? context, Widget page) {
    if (context == null) {
      print("⚠️ Tentativa de navegação falhou: Contexto nulo.");
      return;
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }
}
