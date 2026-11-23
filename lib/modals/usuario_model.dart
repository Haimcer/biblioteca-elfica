import 'package:leitor_ebooks/modals/escritor_model.dart';
import 'package:leitor_ebooks/modals/livro.dart';
import 'as_t.dart';

class UsuarioModel {
  String? id;
  String? nomeUsuario;
  String? email;
  String? foto;
  bool? isWriter;
  DateTime? criadoEm;
  List<UsuarioModel> curtidores;
  List<UsuarioModel> seguidores;
  List<UsuarioModel> seguindo;
  List<LivrosModel> livrosCurtidos;
  EscritorModel? perfilEscritor;

  UsuarioModel({
    this.id,
    this.nomeUsuario,
    this.email,
    this.foto,
    this.isWriter,
    this.criadoEm,
    List<UsuarioModel>? curtidores,
    List<UsuarioModel>? seguidores,
    List<UsuarioModel>? seguindo,
    List<LivrosModel>? livrosCurtidos,
    this.perfilEscritor,
  })  : curtidores = curtidores ?? const [],
        seguidores = seguidores ?? const [],
        seguindo = seguindo ?? const [],
        livrosCurtidos = livrosCurtidos ?? const [];

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    final curtList = json['curtidores'] as List? ?? [];
    final segList = json['seguidores'] as List? ?? [];
    final seguindoList = json['seguindo'] as List? ?? [];
    final livrosCurtidosList = json['livros_curtidos'] as List? ?? [];

    return UsuarioModel(
      id: asT<String>(json['id']),
      nomeUsuario: asT<String>(json['nome_usuario']),
      email: asT<String>(json['email']),
      foto: asT<String>(json['foto']),
      isWriter: asT<bool>(json['is_writer']),
      criadoEm: json['criado_em'] != null ? DateTime.tryParse(json['criado_em']) : null,
      curtidores: curtList.map((e) => UsuarioModel.fromJson(e)).toList(),
      seguidores: segList.map((e) => UsuarioModel.fromJson(e)).toList(),
      seguindo: seguindoList.map((e) => UsuarioModel.fromJson(e)).toList(),
      livrosCurtidos: livrosCurtidosList.map((e) => LivrosModel.fromJson(e)).toList(),
      perfilEscritor: json['perfil_escritor'] != null
          ? EscritorModel.fromJson(json['perfil_escritor'] as Map<String, dynamic>)
          : null,
    );
  }
}
