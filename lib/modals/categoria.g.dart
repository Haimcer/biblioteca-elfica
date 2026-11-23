// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoriaModel on _CategoriaModelBase, Store {
  late final _$idAtom = Atom(name: '_CategoriaModelBase.id', context: context);

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

  late final _$nomeAtom =
      Atom(name: '_CategoriaModelBase.nome', context: context);

  @override
  String? get nome {
    _$nomeAtom.reportRead();
    return super.nome;
  }

  @override
  set nome(String? value) {
    _$nomeAtom.reportWrite(value, super.nome, () {
      super.nome = value;
    });
  }

  late final _$criadoEmAtom =
      Atom(name: '_CategoriaModelBase.criadoEm', context: context);

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
      Atom(name: '_CategoriaModelBase.loading', context: context);

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

  late final _$_CategoriaModelBaseActionController =
      ActionController(name: '_CategoriaModelBase', context: context);

  @override
  void setNome(String? value) {
    final _$actionInfo = _$_CategoriaModelBaseActionController.startAction(
        name: '_CategoriaModelBase.setNome');
    try {
      return super.setNome(value);
    } finally {
      _$_CategoriaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool value) {
    final _$actionInfo = _$_CategoriaModelBaseActionController.startAction(
        name: '_CategoriaModelBase.setLoading');
    try {
      return super.setLoading(value);
    } finally {
      _$_CategoriaModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
nome: ${nome},
criadoEm: ${criadoEm},
loading: ${loading}
    ''';
  }
}
