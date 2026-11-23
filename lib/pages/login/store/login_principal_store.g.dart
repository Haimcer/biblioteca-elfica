// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_principal_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginPrincipalStore on _LoginPrincipalStoreBase, Store {
  late final _$obscureTextSenhaAtom =
      Atom(name: '_LoginPrincipalStoreBase.obscureTextSenha', context: context);

  @override
  bool get obscureTextSenha {
    _$obscureTextSenhaAtom.reportRead();
    return super.obscureTextSenha;
  }

  @override
  set obscureTextSenha(bool value) {
    _$obscureTextSenhaAtom.reportWrite(value, super.obscureTextSenha, () {
      super.obscureTextSenha = value;
    });
  }

  late final _$_LoginPrincipalStoreBaseActionController =
      ActionController(name: '_LoginPrincipalStoreBase', context: context);

  @override
  dynamic setObscureTextSenha() {
    final _$actionInfo = _$_LoginPrincipalStoreBaseActionController.startAction(
        name: '_LoginPrincipalStoreBase.setObscureTextSenha');
    try {
      return super.setObscureTextSenha();
    } finally {
      _$_LoginPrincipalStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
obscureTextSenha: ${obscureTextSenha}
    ''';
  }
}
