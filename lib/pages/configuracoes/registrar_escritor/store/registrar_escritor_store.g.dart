// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registrar_escritor_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResgistrarEscritorStore on _ResgistrarEscritorStoreBase, Store {
  late final _$isAnonimoAtom =
      Atom(name: '_ResgistrarEscritorStoreBase.isAnonimo', context: context);

  @override
  bool get isAnonimo {
    _$isAnonimoAtom.reportRead();
    return super.isAnonimo;
  }

  @override
  set isAnonimo(bool value) {
    _$isAnonimoAtom.reportWrite(value, super.isAnonimo, () {
      super.isAnonimo = value;
    });
  }

  late final _$fotoAtom =
      Atom(name: '_ResgistrarEscritorStoreBase.foto', context: context);

  @override
  dynamic get foto {
    _$fotoAtom.reportRead();
    return super.foto;
  }

  @override
  set foto(dynamic value) {
    _$fotoAtom.reportWrite(value, super.foto, () {
      super.foto = value;
    });
  }

  late final _$_ResgistrarEscritorStoreBaseActionController =
      ActionController(name: '_ResgistrarEscritorStoreBase', context: context);

  @override
  dynamic setFoto(dynamic value) {
    final _$actionInfo = _$_ResgistrarEscritorStoreBaseActionController
        .startAction(name: '_ResgistrarEscritorStoreBase.setFoto');
    try {
      return super.setFoto(value);
    } finally {
      _$_ResgistrarEscritorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIsAnonimo(dynamic value) {
    final _$actionInfo = _$_ResgistrarEscritorStoreBaseActionController
        .startAction(name: '_ResgistrarEscritorStoreBase.setIsAnonimo');
    try {
      return super.setIsAnonimo(value);
    } finally {
      _$_ResgistrarEscritorStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
isAnonimo: ${isAnonimo},
foto: ${foto}
    ''';
  }
}
