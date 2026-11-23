import 'package:mobx/mobx.dart';
import '../../../../modals/livro.dart';

part 'profile_user_store.g.dart';

class ProfileUserStore = _ProfileUserStoreBase with _$ProfileUserStore;

abstract class _ProfileUserStoreBase with Store {
  @observable
  String? nomeUsuario;

  @observable
  String? fotoUsuario;

  @observable
  String? emailUsuario;

  @observable
  int seguidores = 0;

  @observable
  int seguindo = 0;

  @observable
  int qtdPosts = 0;

  @observable
  ObservableList<LivrosModel> livrosRecentes = ObservableList();

  @observable
  ObservableList<LivrosModel> livrosPopulares = ObservableList();

  @observable
  bool loading = false;

  @action
  void setNomeUsuario(String value) {
    print('setNomeUsuario: $value');
    nomeUsuario = value;
  }

  @action
  void setFotoUsuario(String? value) {
    print('setFotoUsuario: $value');
    fotoUsuario = value;
  }

  @action
  void setEmailUsuario(String? value) {
    print('setEmailUsuario: $value');
    emailUsuario = value;
  }

  @action
  void setSeguidores(int value) {
    print('setSeguidores: $value');
    seguidores = value;
  }

  @action
  void setSeguindo(int value) {
    print('setSeguindo: $value');
    seguindo = value;
  }

  @action
  void setQtdPosts(int value) {
    print('setQtdPosts: $value');
    qtdPosts = value;
  }

  @action
  void setLivrosRecentes(List<LivrosModel> lista) {
    print('setLivrosRecentes: ${lista.length} items');
    livrosRecentes = ObservableList.of(lista);
  }

  @action
  void setLivrosPopulares(List<LivrosModel> lista) {
    print('setLivrosPopulares: ${lista.length} items');
    livrosPopulares = ObservableList.of(lista);
  }

  @action
  void setLoading(bool value) {
    print('setLoading: $value');
    loading = value;
  }

  @action
  void clear() {
    print('clear store');
    nomeUsuario = null;
    fotoUsuario = null;
    emailUsuario = null;
    seguidores = 0;
    seguindo = 0;
    qtdPosts = 0;
    livrosRecentes.clear();
    livrosPopulares.clear();
    loading = false;
  }
}
