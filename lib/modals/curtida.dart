import 'package:mobx/mobx.dart';

part 'curtida.g.dart';

class CurtidaModel = _CurtidaModelBase with _$CurtidaModel;

abstract class _CurtidaModelBase with Store {
  @observable
  String? usuarioId;

  @observable
  String? nomeUsuario;

  @observable
  String? foto;

  @observable
  bool loading = false;

  _CurtidaModelBase({
    this.usuarioId,
    this.nomeUsuario,
    this.foto,
    this.loading = false,
  });

  _CurtidaModelBase.fromJson(Map<String, dynamic> json) {
    usuarioId = json['id'];
    nomeUsuario = json['nome_usuario'];
    foto = json['foto'];
    loading = false;
  }

  @action
  void setLoading(bool value) => loading = value;
}
