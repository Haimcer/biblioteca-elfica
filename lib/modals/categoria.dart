import 'package:mobx/mobx.dart';

part 'categoria.g.dart';

class CategoriaModel = _CategoriaModelBase with _$CategoriaModel;

abstract class _CategoriaModelBase with Store {
  @observable
  int? id;

  @observable
  String? nome;

  @observable
  DateTime? criadoEm;

  @observable
  bool loading = false;

  _CategoriaModelBase({
    this.id,
    this.nome,
    this.criadoEm,
    this.loading = false,
  });

  _CategoriaModelBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    criadoEm = DateTime.tryParse(json['criado_em'] ?? '');
    loading = false;
  }

  @action
  void setNome(String? value) => nome = value;

  @action
  void setLoading(bool value) => loading = value;
}
