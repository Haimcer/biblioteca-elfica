import 'package:mobx/mobx.dart';
part 'login_principal_store.g.dart';

class LoginPrincipalStore = _LoginPrincipalStoreBase with _$LoginPrincipalStore;

abstract class _LoginPrincipalStoreBase with Store {
  
  @observable
  bool obscureTextSenha = true ;
  @action
  setObscureTextSenha() => obscureTextSenha = !obscureTextSenha;
}