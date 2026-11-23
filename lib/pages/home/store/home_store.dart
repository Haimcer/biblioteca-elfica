import 'package:mobx/mobx.dart';

import '../../../modals/livro.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  @observable
  ObservableList<LivrosModel> listModelMobX = ObservableList<LivrosModel>();

  @action
  void setAllListMobX(List<LivrosModel> list) {
    listModelMobX.clear();
    listModelMobX.addAll(list);
  }

  @action
  void listReload() {
    final list = List<LivrosModel>.from(listModelMobX);
    listModelMobX.clear();
    setAllListMobX(list);
  }

  @action
  void setListModelMobX(LivrosModel ficha) {
    listModelMobX.add(ficha);
  }

  @action
  void setListModelMobXClear() {
    listModelMobX.clear();
  }
}
