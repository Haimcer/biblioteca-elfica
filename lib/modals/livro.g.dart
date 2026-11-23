// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'livro.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LivrosModel on _LivrosModelBase, Store {
  Computed<String>? _$precoFormatadoComputed;

  @override
  String get precoFormatado =>
      (_$precoFormatadoComputed ??= Computed<String>(() => super.precoFormatado,
              name: '_LivrosModelBase.precoFormatado'))
          .value;

  late final _$idAtom = Atom(name: '_LivrosModelBase.id', context: context);

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

  late final _$titleAtom =
      Atom(name: '_LivrosModelBase.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_LivrosModelBase.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$coverUrlAtom =
      Atom(name: '_LivrosModelBase.coverUrl', context: context);

  @override
  String? get coverUrl {
    _$coverUrlAtom.reportRead();
    return super.coverUrl;
  }

  @override
  set coverUrl(String? value) {
    _$coverUrlAtom.reportWrite(value, super.coverUrl, () {
      super.coverUrl = value;
    });
  }

  late final _$downloadUrlAtom =
      Atom(name: '_LivrosModelBase.downloadUrl', context: context);

  @override
  String? get downloadUrl {
    _$downloadUrlAtom.reportRead();
    return super.downloadUrl;
  }

  @override
  set downloadUrl(String? value) {
    _$downloadUrlAtom.reportWrite(value, super.downloadUrl, () {
      super.downloadUrl = value;
    });
  }

  late final _$isPremiumAtom =
      Atom(name: '_LivrosModelBase.isPremium', context: context);

  @override
  bool? get isPremium {
    _$isPremiumAtom.reportRead();
    return super.isPremium;
  }

  @override
  set isPremium(bool? value) {
    _$isPremiumAtom.reportWrite(value, super.isPremium, () {
      super.isPremium = value;
    });
  }

  late final _$isFreeAtom =
      Atom(name: '_LivrosModelBase.isFree', context: context);

  @override
  bool? get isFree {
    _$isFreeAtom.reportRead();
    return super.isFree;
  }

  @override
  set isFree(bool? value) {
    _$isFreeAtom.reportWrite(value, super.isFree, () {
      super.isFree = value;
    });
  }

  late final _$precoAtom =
      Atom(name: '_LivrosModelBase.preco', context: context);

  @override
  int? get preco {
    _$precoAtom.reportRead();
    return super.preco;
  }

  @override
  set preco(int? value) {
    _$precoAtom.reportWrite(value, super.preco, () {
      super.preco = value;
    });
  }

  late final _$codigoMoedaAtom =
      Atom(name: '_LivrosModelBase.codigoMoeda', context: context);

  @override
  String? get codigoMoeda {
    _$codigoMoedaAtom.reportRead();
    return super.codigoMoeda;
  }

  @override
  set codigoMoeda(String? value) {
    _$codigoMoedaAtom.reportWrite(value, super.codigoMoeda, () {
      super.codigoMoeda = value;
    });
  }

  late final _$categoryIdAtom =
      Atom(name: '_LivrosModelBase.categoryId', context: context);

  @override
  int? get categoryId {
    _$categoryIdAtom.reportRead();
    return super.categoryId;
  }

  @override
  set categoryId(int? value) {
    _$categoryIdAtom.reportWrite(value, super.categoryId, () {
      super.categoryId = value;
    });
  }

  late final _$categoriaAtom =
      Atom(name: '_LivrosModelBase.categoria', context: context);

  @override
  String? get categoria {
    _$categoriaAtom.reportRead();
    return super.categoria;
  }

  @override
  set categoria(String? value) {
    _$categoriaAtom.reportWrite(value, super.categoria, () {
      super.categoria = value;
    });
  }

  late final _$idiomaAtom =
      Atom(name: '_LivrosModelBase.idioma', context: context);

  @override
  String? get idioma {
    _$idiomaAtom.reportRead();
    return super.idioma;
  }

  @override
  set idioma(String? value) {
    _$idiomaAtom.reportWrite(value, super.idioma, () {
      super.idioma = value;
    });
  }

  late final _$regiaoAtom =
      Atom(name: '_LivrosModelBase.regiao', context: context);

  @override
  String? get regiao {
    _$regiaoAtom.reportRead();
    return super.regiao;
  }

  @override
  set regiao(String? value) {
    _$regiaoAtom.reportWrite(value, super.regiao, () {
      super.regiao = value;
    });
  }

  late final _$criadoEmAtom =
      Atom(name: '_LivrosModelBase.criadoEm', context: context);

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

  late final _$authorAtom =
      Atom(name: '_LivrosModelBase.author', context: context);

  @override
  EscritorModel? get author {
    _$authorAtom.reportRead();
    return super.author;
  }

  @override
  set author(EscritorModel? value) {
    _$authorAtom.reportWrite(value, super.author, () {
      super.author = value;
    });
  }

  late final _$usuarioAtom =
      Atom(name: '_LivrosModelBase.usuario', context: context);

  @override
  UsuarioModel? get usuario {
    _$usuarioAtom.reportRead();
    return super.usuario;
  }

  @override
  set usuario(UsuarioModel? value) {
    _$usuarioAtom.reportWrite(value, super.usuario, () {
      super.usuario = value;
    });
  }

  late final _$qtdCurtidasAtom =
      Atom(name: '_LivrosModelBase.qtdCurtidas', context: context);

  @override
  int? get qtdCurtidas {
    _$qtdCurtidasAtom.reportRead();
    return super.qtdCurtidas;
  }

  @override
  set qtdCurtidas(int? value) {
    _$qtdCurtidasAtom.reportWrite(value, super.qtdCurtidas, () {
      super.qtdCurtidas = value;
    });
  }

  late final _$qtdComentariosAtom =
      Atom(name: '_LivrosModelBase.qtdComentarios', context: context);

  @override
  int? get qtdComentarios {
    _$qtdComentariosAtom.reportRead();
    return super.qtdComentarios;
  }

  @override
  set qtdComentarios(int? value) {
    _$qtdComentariosAtom.reportWrite(value, super.qtdComentarios, () {
      super.qtdComentarios = value;
    });
  }

  late final _$listCurtidasAtom =
      Atom(name: '_LivrosModelBase.listCurtidas', context: context);

  @override
  List<CurtidaModel> get listCurtidas {
    _$listCurtidasAtom.reportRead();
    return super.listCurtidas;
  }

  @override
  set listCurtidas(List<CurtidaModel> value) {
    _$listCurtidasAtom.reportWrite(value, super.listCurtidas, () {
      super.listCurtidas = value;
    });
  }

  late final _$listComentariosAtom =
      Atom(name: '_LivrosModelBase.listComentarios', context: context);

  @override
  List<ComentarioModel> get listComentarios {
    _$listComentariosAtom.reportRead();
    return super.listComentarios;
  }

  @override
  set listComentarios(List<ComentarioModel> value) {
    _$listComentariosAtom.reportWrite(value, super.listComentarios, () {
      super.listComentarios = value;
    });
  }

  late final _$favoriteAtom =
      Atom(name: '_LivrosModelBase.favorite', context: context);

  @override
  bool get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(bool value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_LivrosModelBase.loading', context: context);

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

  late final _$localDirectoryAtom =
      Atom(name: '_LivrosModelBase.localDirectory', context: context);

  @override
  String? get localDirectory {
    _$localDirectoryAtom.reportRead();
    return super.localDirectory;
  }

  @override
  set localDirectory(String? value) {
    _$localDirectoryAtom.reportWrite(value, super.localDirectory, () {
      super.localDirectory = value;
    });
  }

  late final _$isDownloadOkAtom =
      Atom(name: '_LivrosModelBase.isDownloadOk', context: context);

  @override
  bool? get isDownloadOk {
    _$isDownloadOkAtom.reportRead();
    return super.isDownloadOk;
  }

  @override
  set isDownloadOk(bool? value) {
    _$isDownloadOkAtom.reportWrite(value, super.isDownloadOk, () {
      super.isDownloadOk = value;
    });
  }

  late final _$_LivrosModelBaseActionController =
      ActionController(name: '_LivrosModelBase', context: context);

  @override
  void setFavorite(bool v) {
    final _$actionInfo = _$_LivrosModelBaseActionController.startAction(
        name: '_LivrosModelBase.setFavorite');
    try {
      return super.setFavorite(v);
    } finally {
      _$_LivrosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool v) {
    final _$actionInfo = _$_LivrosModelBaseActionController.startAction(
        name: '_LivrosModelBase.setLoading');
    try {
      return super.setLoading(v);
    } finally {
      _$_LivrosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLocalDirectory(String? v) {
    final _$actionInfo = _$_LivrosModelBaseActionController.startAction(
        name: '_LivrosModelBase.setLocalDirectory');
    try {
      return super.setLocalDirectory(v);
    } finally {
      _$_LivrosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsDownloadOk(bool? v) {
    final _$actionInfo = _$_LivrosModelBaseActionController.startAction(
        name: '_LivrosModelBase.setIsDownloadOk');
    try {
      return super.setIsDownloadOk(v);
    } finally {
      _$_LivrosModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
title: ${title},
description: ${description},
coverUrl: ${coverUrl},
downloadUrl: ${downloadUrl},
isPremium: ${isPremium},
isFree: ${isFree},
preco: ${preco},
codigoMoeda: ${codigoMoeda},
categoryId: ${categoryId},
categoria: ${categoria},
idioma: ${idioma},
regiao: ${regiao},
criadoEm: ${criadoEm},
author: ${author},
usuario: ${usuario},
qtdCurtidas: ${qtdCurtidas},
qtdComentarios: ${qtdComentarios},
listCurtidas: ${listCurtidas},
listComentarios: ${listComentarios},
favorite: ${favorite},
loading: ${loading},
localDirectory: ${localDirectory},
isDownloadOk: ${isDownloadOk},
precoFormatado: ${precoFormatado}
    ''';
  }
}
