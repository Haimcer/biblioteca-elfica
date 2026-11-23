// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curtida.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CurtidaModel on _CurtidaModelBase, Store {
  late final _$usuarioIdAtom =
      Atom(name: '_CurtidaModelBase.usuarioId', context: context);

  @override
  String? get usuarioId {
    _$usuarioIdAtom.reportRead();
    return super.usuarioId;
  }

  @override
  set usuarioId(String? value) {
    _$usuarioIdAtom.reportWrite(value, super.usuarioId, () {
      super.usuarioId = value;
    });
  }

  late final _$nomeUsuarioAtom =
      Atom(name: '_CurtidaModelBase.nomeUsuario', context: context);

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
      Atom(name: '_CurtidaModelBase.foto', context: context);

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

  late final _$loadingAtom =
      Atom(name: '_CurtidaModelBase.loading', context: context);

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

  late final _$_CurtidaModelBaseActionController =
      ActionController(name: '_CurtidaModelBase', context: context);

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CurtidaModelBaseActionController.startAction(
        name: '_CurtidaModelBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CurtidaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
usuarioId: ${usuarioId},
nomeUsuario: ${nomeUsuario},
foto: ${foto},
loading: ${loading}
    ''';
  }
}
