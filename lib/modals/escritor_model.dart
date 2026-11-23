import 'package:leitor_ebooks/modals/livro.dart';
import 'as_t.dart';
import 'usuario_model.dart';

class EscritorModel {
  // ─── dados básicos ───────────────────────────────
  final int? id;
  final String? usuarioId;

  final String? nomeUsuario; // nick público
  final String? foto;

  final String? nomeCompleto;
  final DateTime? dataNascimento;
  final String? cpf;
  final String? telefone;

  final String? enderecoLinha1;
  final String? enderecoLinha2;
  final String? cidade;
  final String? estado;
  final String? cep;
  final String? pais;

  final String? contaBancaria;
  final String? stripeAccountId;

  final bool? isAnonimo;
  final DateTime? criadoEm;

  // ─── listas relacionais ─────────────────────────
  final List<UsuarioModel> curtidores;
  final List<LivrosModel> livrosPublicados;
  final List<UsuarioModel> seguidores;
  final List<UsuarioModel> seguindo;

  EscritorModel({
    this.id,
    this.usuarioId,
    this.nomeUsuario,
    this.foto,
    this.nomeCompleto,
    this.dataNascimento,
    this.cpf,
    this.telefone,
    this.enderecoLinha1,
    this.enderecoLinha2,
    this.cidade,
    this.estado,
    this.cep,
    this.pais,
    this.contaBancaria,
    this.stripeAccountId,
    this.isAnonimo,
    this.criadoEm,
    List<UsuarioModel>? curtidores,
    List<LivrosModel>? livrosPublicados,
    List<UsuarioModel>? seguidores,
    List<UsuarioModel>? seguindo,
  })  : curtidores = curtidores ?? const [],
        livrosPublicados = livrosPublicados ?? const [],
        seguidores = seguidores ?? const [],
        seguindo = seguindo ?? const [];

  factory EscritorModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) return EscritorModel();

    // debug prints
    // print("EscritorModel.fromJson called");
    // print("id: ${json['id']}");
    // print("usuario_id: ${json['usuario_id']}");
    // print("nome_usuario: ${json['nome_usuario']}");
    print("foto: ${json['foto']}");
    // print("nome_completo: ${json['nome_completo']}");
    // print("data_nascimento: ${json['data_nascimento']}");
    // print("cpf: ${json['cpf']}");
    // print("telefone: ${json['telefone']}");
    // print("endereco_linha1: ${json['endereco_linha1']}");
    // print("endereco_linha2: ${json['endereco_linha2']}");
    // print("cidade: ${json['cidade']}");
    // print("estado: ${json['estado']}");
    // print("cep: ${json['cep']}");
    // print("pais: ${json['pais']}");
    // print("conta_bancaria: ${json['conta_bancaria']}");
    // print("stripe_account_id: ${json['stripe_account_id']}");
    // print("is_anonimo: ${json['is_anonimo']}");
    // print("criado_em: ${json['criado_em']}");
    final curtList = json['curtidores'] as List? ?? [];
    // print("curtidores count: ${curtList.length}");
    final livrosList = json['livrosPublicados'] as List? ?? [];
    // print("livrosPublicados count: ${livrosList.length}");
    final segList = json['seguidores'] as List? ?? [];
    // print("seguidores count: ${segList.length}");
    final seguindoList = json['seguindo'] as List? ?? [];
    // print("seguindo count: ${seguindoList.length}");

    return EscritorModel(
      id: asT<int>(json['id']),
      usuarioId: asT<String>(json['usuario_id']),
      nomeUsuario: asT<String>(json['nome_usuario']),
      foto: asT<String>(json['foto']),
      nomeCompleto: asT<String>(json['nome_completo']),
      dataNascimento: json['data_nascimento'] != null
          ? DateTime.tryParse(json['data_nascimento'])
          : null,
      cpf: asT<String>(json['cpf']),
      telefone: asT<String>(json['telefone']),
      enderecoLinha1: asT<String>(json['endereco_linha1']),
      enderecoLinha2: asT<String>(json['endereco_linha2']),
      cidade: asT<String>(json['cidade']),
      estado: asT<String>(json['estado']),
      cep: asT<String>(json['cep']),
      pais: asT<String>(json['pais']),
      contaBancaria: asT<String>(json['conta_bancaria']),
      stripeAccountId: asT<String>(json['stripe_account_id']),
      isAnonimo: asT<bool>(json['is_anonimo']),
      criadoEm: json['criado_em'] != null
          ? DateTime.tryParse(json['criado_em'])
          : null,
      curtidores: curtList.map((e) => UsuarioModel.fromJson(e)).toList(),
      livrosPublicados: livrosList.map((e) => LivrosModel.fromJson(e)).toList(),
      seguidores: segList.map((e) => UsuarioModel.fromJson(e)).toList(),
      seguindo: seguindoList.map((e) => UsuarioModel.fromJson(e)).toList(),
    );
  }
}
