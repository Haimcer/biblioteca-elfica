import 'package:flutter/material.dart';
import '../modals/usuario_model.dart';

class UserInfos extends ChangeNotifier {
  UsuarioModel _usuario = UsuarioModel();

  UsuarioModel get usuario => _usuario;

  void setUsuario(UsuarioModel value) {
    _usuario = value;
    notifyListeners();
  }

  void atualizarFoto(String urlNova) {
    _usuario.foto = urlNova;
    notifyListeners();
  }

  void atualizarNomeUsuario(String novoNome) {
    _usuario.nomeUsuario = novoNome;
    notifyListeners();
  }

  void limparUsuario() {
    _usuario = UsuarioModel();
    notifyListeners();
  }
}
