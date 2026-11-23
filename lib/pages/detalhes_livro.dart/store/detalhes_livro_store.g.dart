// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detalhes_livro_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LivroDetalhesStore on _LivroDetalhesStoreBase, Store {
  late final _$livroAtom =
      Atom(name: '_LivroDetalhesStoreBase.livro', context: context);

  @override
  LivrosModel? get livro {
    _$livroAtom.reportRead();
    return super.livro;
  }

  @override
  set livro(LivrosModel? value) {
    _$livroAtom.reportWrite(value, super.livro, () {
      super.livro = value;
    });
  }

  late final _$comentariosAtom =
      Atom(name: '_LivroDetalhesStoreBase.comentarios', context: context);

  @override
  ObservableList<ComentarioModel> get comentarios {
    _$comentariosAtom.reportRead();
    return super.comentarios;
  }

  @override
  set comentarios(ObservableList<ComentarioModel> value) {
    _$comentariosAtom.reportWrite(value, super.comentarios, () {
      super.comentarios = value;
    });
  }

  late final _$curtidasAtom =
      Atom(name: '_LivroDetalhesStoreBase.curtidas', context: context);

  @override
  ObservableList<CurtidaModel> get curtidas {
    _$curtidasAtom.reportRead();
    return super.curtidas;
  }

  @override
  set curtidas(ObservableList<CurtidaModel> value) {
    _$curtidasAtom.reportWrite(value, super.curtidas, () {
      super.curtidas = value;
    });
  }

  late final _$loadingAtom =
      Atom(name: '_LivroDetalhesStoreBase.loading', context: context);

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

  late final _$comentarioControllerAtom = Atom(
      name: '_LivroDetalhesStoreBase.comentarioController', context: context);

  @override
  TextEditingController get comentarioController {
    _$comentarioControllerAtom.reportRead();
    return super.comentarioController;
  }

  @override
  set comentarioController(TextEditingController value) {
    _$comentarioControllerAtom.reportWrite(value, super.comentarioController,
        () {
      super.comentarioController = value;
    });
  }

  late final _$carregarLivroAsyncAction =
      AsyncAction('_LivroDetalhesStoreBase.carregarLivro', context: context);

  @override
  Future<void> carregarLivro(int livroId) {
    return _$carregarLivroAsyncAction.run(() => super.carregarLivro(livroId));
  }

  late final _$comentarAsyncAction =
      AsyncAction('_LivroDetalhesStoreBase.comentar', context: context);

  @override
  Future<void> comentar() {
    return _$comentarAsyncAction.run(() => super.comentar());
  }

  late final _$alternarCurtidaAsyncAction =
      AsyncAction('_LivroDetalhesStoreBase.alternarCurtida', context: context);

  @override
  Future<void> alternarCurtida() {
    return _$alternarCurtidaAsyncAction.run(() => super.alternarCurtida());
  }

  late final _$setLivroAsyncAction =
      AsyncAction('_LivroDetalhesStoreBase.setLivro', context: context);

  @override
  Future<void> setLivro(LivrosModel livrosModel) {
    return _$setLivroAsyncAction.run(() => super.setLivro(livrosModel));
  }

  @override
  String toString() {
    return '''
livro: ${livro},
comentarios: ${comentarios},
curtidas: ${curtidas},
loading: ${loading},
comentarioController: ${comentarioController}
    ''';
  }
}
