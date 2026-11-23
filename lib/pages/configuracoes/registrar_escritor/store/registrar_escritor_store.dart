import 'dart:typed_data';

import 'package:mobx/mobx.dart';
part 'registrar_escritor_store.g.dart';

class ResgistrarEscritorStore = _ResgistrarEscritorStoreBase
    with _$ResgistrarEscritorStore;

abstract class _ResgistrarEscritorStoreBase with Store {
  @observable
  bool isAnonimo = false;

  @observable
  dynamic foto;

  @action
  setFoto(value) => foto = value;

  @action
  setIsAnonimo(value) => isAnonimo = value;
}
