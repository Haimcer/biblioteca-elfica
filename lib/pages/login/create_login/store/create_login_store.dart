import 'package:mobx/mobx.dart';
part 'create_login_store.g.dart';

class CreateLoginStore = _CreateLoginStoreBase with _$CreateLoginStore;

abstract class _CreateLoginStoreBase with Store {
  @observable
  bool obscureTextSenha = true ;
  @action
  setObscureTextSenha() => obscureTextSenha = !obscureTextSenha;

  @observable
  bool obscureTextConfSenha = true ;
  @action
  setObscureTextConfSenha() => obscureTextConfSenha = !obscureTextConfSenha;
  
}