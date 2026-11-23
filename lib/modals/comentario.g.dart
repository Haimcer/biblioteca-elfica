// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comentario.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ComentarioModel on _ComentarioModelBase, Store {
  late final _$idAtom = Atom(name: '_ComentarioModelBase.id', context: context);

  @override
  int? get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(int? value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$mensagemAtom =
      Atom(name: '_ComentarioModelBase.mensagem', context: context);

  @override
  String? get mensagem {
    _$mensagemAtom.reportRead();
    return super.mensagem;
  }

  @override
  set mensagem(String? value) {
    _$mensagemAtom.reportWrite(value, super.mensagem, () {
      super.mensagem = value;
    });
  }

  late final _$nomeUsuarioAtom =
      Atom(name: '_ComentarioModelBase.nomeUsuario', context: context);

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

  late final _$fotoAtom =
      Atom(name: '_ComentarioModelBase.foto', context: context);

  @override
  String? get foto {
    _$fotoAtom.reportRead();
    return super.foto;
  }

  @override
  set foto(String? value) {
    _$fotoAtom.reportWrite(value, super.foto, () {
      super.foto = value;
    });
  }

  late final _$criadoEmAtom =
      Atom(name: '_ComentarioModelBase.criadoEm', context: context);

  @override
  DateTime? get criadoEm {
    _$criadoEmAtom.reportRead();
    return super.criadoEm;
  }

  @override
  set criadoEm(DateTime? value) {
    _$criadoEmAtom.reportWrite(value, super.criadoEm, () {
      super.criadoEm = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_ComentarioModelBase.loading', context: context);

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

  late final _$_ComentarioModelBaseActionController =
      ActionController(name: '_ComentarioModelBase', context: context);

  @override
  void setMensagem(String? value) {
    final _$actionInfo = _$_ComentarioModelBaseActionController.startAction(
        name: '_ComentarioModelBase.setMensagem');
    try {
      return super.setMensagem(value);
    } finally {
      _$_ComentarioModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_ComentarioModelBaseActionController.startAction(
        name: '_ComentarioModelBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_ComentarioModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
mensagem: ${mensagem},
nomeUsuario: ${nomeUsuario},
foto: ${foto},
criadoEm: ${criadoEm},
loading: ${loading}
    ''';
  }
}
