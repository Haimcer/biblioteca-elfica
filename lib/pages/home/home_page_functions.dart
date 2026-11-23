import 'package:flutter/material.dart';
import 'package:leitor_ebooks/request/livros/get_livros.dart';
import 'package:leitor_ebooks/globals/globals_local_storage.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import '../../globals/store/globals_store.dart';
import '../../modals/livro.dart';

class HomePrincipalFunctions {
  BuildContext context;
  HomePrincipalFunctions(this.context);

  late HomeStore homeStoreAux;
  late GlobalsStore globalsStoreAux;
  bool loading = false;
  List<String> listDownloads = [];
  List<String> listFavorite = [];

  Future homeFunctionPrincipal(
      BuildContext contextAux,
      GlobalsStore globalsStore,
      HomeStore homeStore,
      String categoriaId) async {
    listFavorite.clear();
    listDownloads.clear();
    await _loadDownloadsAndFavorites();

    globalsStoreAux = globalsStore;
    homeStoreAux = homeStore;

    if (homeStore.listModelMobX.isEmpty) {
      await _fetchLivros(homeStore, categoriaId, contextAux);
    }
  }

  Future<void> _loadDownloadsAndFavorites() async {
    final response = await GlobalsLocalStorage().getDownloads();
    final favorite = await GlobalsLocalStorage().getFavorite();
    listFavorite.addAll(favorite ?? []);
    listDownloads.addAll(response ?? []);
  }

  Future<void> _fetchLivros(
    HomeStore homeStore,
    String categoriaId,
    BuildContext contextAux,
  ) async {
    try {
      var result = await GetLivrosRequest(contextAux)
          .getLivros(categoriaId: categoriaId == '' ? null : categoriaId);
      if (result != null) {
        result.forEach((value) {
          homeStore.setListModelMobX(LivrosModel.fromJson(value));
        });
      }
    } catch (e) {
      print("Erro ao buscar livros: $e");
    }
  }
}
