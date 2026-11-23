// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileUserStore on _ProfileUserStoreBase, Store {
  late final _$nomeUsuarioAtom =
      Atom(name: '_ProfileUserStoreBase.nomeUsuario', context: context);

  @override
  String? get nomeUsuario {
    _$nomeUsuarioAtom.reportRead();
    return super.nomeUsuario;
  }

  @override
  set nomeUsuario(String? value) {
    _$nomeUsuarioAtom.reportWrite(value, super.nomeUsuario, () {
      super.nomeUsuario = value;
    });
  }

  late final _$fotoUsuarioAtom =
      Atom(name: '_ProfileUserStoreBase.fotoUsuario', context: context);

  @override
  String? get fotoUsuario {
    _$fotoUsuarioAtom.reportRead();
    return super.fotoUsuario;
  }

  @override
  set fotoUsuario(String? value) {
    _$fotoUsuarioAtom.reportWrite(value, super.fotoUsuario, () {
      super.fotoUsuario = value;
    });
  }

  late final _$emailUsuarioAtom =
      Atom(name: '_ProfileUserStoreBase.emailUsuario', context: context);

  @override
  String? get emailUsuario {
    _$emailUsuarioAtom.reportRead();
    return super.emailUsuario;
  }

  @override
  set emailUsuario(String? value) {
    _$emailUsuarioAtom.reportWrite(value, super.emailUsuario, () {
      super.emailUsuario = value;
    });
  }

  late final _$seguidoresAtom =
      Atom(name: '_ProfileUserStoreBase.seguidores', context: context);

  @override
  int get seguidores {
    _$seguidoresAtom.reportRead();
    return super.seguidores;
  }

  @override
  set seguidores(int value) {
    _$seguidoresAtom.reportWrite(value, super.seguidores, () {
      super.seguidores = value;
    });
  }

  late final _$seguindoAtom =
      Atom(name: '_ProfileUserStoreBase.seguindo', context: context);

  @override
  int get seguindo {
    _$seguindoAtom.reportRead();
    return super.seguindo;
  }

  @override
  set seguindo(int value) {
    _$seguindoAtom.reportWrite(value, super.seguindo, () {
      super.seguindo = value;
    });
  }

  late final _$qtdPostsAtom =
      Atom(name: '_ProfileUserStoreBase.qtdPosts', context: context);

  @override
  int get qtdPosts {
    _$qtdPostsAtom.reportRead();
    return super.qtdPosts;
  }

  @override
  set qtdPosts(int value) {
    _$qtdPostsAtom.reportWrite(value, super.qtdPosts, () {
      super.qtdPosts = value;
    });
  }

  late final _$livrosRecentesAtom =
      Atom(name: '_ProfileUserStoreBase.livrosRecentes', context: context);

  @override
  ObservableList<LivrosModel> get livrosRecentes {
    _$livrosRecentesAtom.reportRead();
    return super.livrosRecentes;
  }

  @override
  set livrosRecentes(ObservableList<LivrosModel> value) {
    _$livrosRecentesAtom.reportWrite(value, super.livrosRecentes, () {
      super.livrosRecentes = value;
    });
  }

  late final _$livrosPopularesAtom =
      Atom(name: '_ProfileUserStoreBase.livrosPopulares', context: context);

  @override
  ObservableList<LivrosModel> get livrosPopulares {
    _$livrosPopularesAtom.reportRead();
    return super.livrosPopulares;
  }

  @override
  set livrosPopulares(ObservableList<LivrosModel> value) {
    _$livrosPopularesAtom.reportWrite(value, super.livrosPopulares, () {
      super.livrosPopulares = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_ProfileUserStoreBase.loading', context: context);

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  late final _$_ProfileUserStoreBaseActionController =
      ActionController(name: '_ProfileUserStoreBase', context: context);

  @override
  void setNomeUsuario(String value) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setNomeUsuario');
    try {
      return super.setNomeUsuario(value);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFotoUsuario(String? value) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setFotoUsuario');
    try {
      return super.setFotoUsuario(value);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEmailUsuario(String? value) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setEmailUsuario');
    try {
      return super.setEmailUsuario(value);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSeguidores(int value) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setSeguidores');
    try {
      return super.setSeguidores(value);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSeguindo(int value) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setSeguindo');
    try {
      return super.setSeguindo(value);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQtdPosts(int value) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setQtdPosts');
    try {
      return super.setQtdPosts(value);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLivrosRecentes(List<LivrosModel> lista) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setLivrosRecentes');
    try {
      return super.setLivrosRecentes(lista);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLivrosPopulares(List<LivrosModel> lista) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setLivrosPopulares');
    try {
      return super.setLivrosPopulares(lista);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clear() {
    final _$actionInfo = _$_ProfileUserStoreBaseActionController.startAction(
        name: '_ProfileUserStoreBase.clear');
    try {
      return super.clear();
    } finally {
      _$_ProfileUserStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
nomeUsuario: ${nomeUsuario},
fotoUsuario: ${fotoUsuario},
emailUsuario: ${emailUsuario},
seguidores: ${seguidores},
seguindo: ${seguindo},
qtdPosts: ${qtdPosts},
livrosRecentes: ${livrosRecentes},
livrosPopulares: ${livrosPopulares},
loading: ${loading}
    ''';
  }
}
