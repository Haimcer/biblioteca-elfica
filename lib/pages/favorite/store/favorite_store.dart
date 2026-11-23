import 'package:mobx/mobx.dart';

import '../../../modals/livro.dart';

part 'favorite_store.g.dart';

class FavoriteStore = _FavoriteStore with _$FavoriteStore;

abstract class _FavoriteStore with Store {
  @observable
  ObservableList<LivrosModel> listModelFavoriteMobX =
      ObservableList<LivrosModel>();

  @action
  void setAllListFavoriteMobX(List<LivrosModel> list) {
    listModelFavoriteMobX.clear();
    listModelFavoriteMobX.addAll(list);
  }

  @action
  void listReload() {
    final list = List<LivrosModel>.from(listModelFavoriteMobX);
    listModelFavoriteMobX.clear();
    setAllListFavoriteMobX(list);
  }

  @action
  void setListModelFavoriteMobX(LivrosModel ficha) {
    listModelFavoriteMobX.add(ficha);
  }

  @action
  void setListModelFavoriteMobXClear() {
    listModelFavoriteMobX.clear();
  }
}
