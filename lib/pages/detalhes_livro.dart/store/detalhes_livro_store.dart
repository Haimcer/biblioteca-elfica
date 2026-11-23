import 'package:leitor_ebooks/request/comentarios/post_comentar.dart';
import 'package:leitor_ebooks/request/curtidas/post_toggle_curtida.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter/material.dart';
import '../../../modals/livro.dart';
import '../../../modals/comentario.dart';
import '../../../modals/curtida.dart';
import '../../../request/livros/get_livro_por_id.dart';

part 'detalhes_livro_store.g.dart';

class LivroDetalhesStore = _LivroDetalhesStoreBase with _$LivroDetalhesStore;

abstract class _LivroDetalhesStoreBase with Store {
  final BuildContext contextAux;

  _LivroDetalhesStoreBase(this.contextAux);

  @observable
  LivrosModel? livro;

  @observable
  ObservableList<ComentarioModel> comentarios = ObservableList();

  @observable
  ObservableList<CurtidaModel> curtidas = ObservableList();

  @observable
  bool loading = false;

@observable
TextEditingController comentarioController = TextEditingController();

  @action
  Future<void> carregarLivro(int livroId) async {
    loading = true;
    final response = await GetLivroPorIdRequest(contextAux).getLivro(livroId.toString());
    if (response != null) {
      livro =   LivrosModel.fromJson(response);
      comentarios = ObservableList.of((livro?.listComentarios ?? []) as Iterable<ComentarioModel>);
      curtidas = ObservableList.of(livro?.listCurtidas ?? []);
    }
    loading = false;
  }

 @action
Future<void> comentar() async {
  if (livro == null || comentarioController.text.trim().isEmpty) return;

  final response = await PostComentarLivroRequest(contextAux).comentarLivro(
    livroId: livro!.id!.toString(),
    mensagem: comentarioController.text.trim(),
  );

  if (response != null) {
    comentarioController.clear(); // limpa o campo
    await carregarLivro(livro!.id!); // recarrega dados atualizados
  }
}


  @action
  Future<void> alternarCurtida() async {
    if (livro == null) return;

    final response = await PostToggleCurtida(contextAux)
        .toggleCurtida(livro!.id!.toString());

    if (response) {
      await carregarLivro(livro!.id!); // Recarrega com a nova curtida
    }
  }

  
  @action
  Future<void> setLivro(LivrosModel livrosModel) async {
   livro = livrosModel;
  }
}
