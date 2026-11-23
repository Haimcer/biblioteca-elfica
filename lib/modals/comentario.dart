import 'package:mobx/mobx.dart';

part 'comentario.g.dart';

class ComentarioModel = _ComentarioModelBase with _$ComentarioModel;

abstract class _ComentarioModelBase with Store {
  @observable
  int? id;

  @observable
  String? mensagem;

  @observable
  String? nomeUsuario;

  @observable
  String? foto;

  @observable
  DateTime? criadoEm;

  @observable
  bool loading = false;

  _ComentarioModelBase({
    this.id,
    this.mensagem,
    this.nomeUsuario,
    this.foto,
    this.criadoEm,
    this.loading = false,
  });

  _ComentarioModelBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mensagem = json['mensagem'];
    nomeUsuario = json['nome_usuario'];
    foto = json['foto'];
    criadoEm = DateTime.tryParse(json['criado_em'] ?? '');
    loading = false;
  }

  @action
  void setMensagem(String? value) => mensagem = value;

  @action
  void setLoading(bool value) => loading = value;
}
