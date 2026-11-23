import 'package:mobx/mobx.dart';
part 'globals_store.g.dart';

class GlobalsStore = _GlobalsStoreBase with _$GlobalsStore;

abstract class _GlobalsStoreBase with Store {
  @observable
  bool loading = false;

  @observable
  String nomeCategoria = '';

  @action
  setNomeCategoria(value) => nomeCategoria = value;
  @action
  setLoading(value) => loading = value;
}
