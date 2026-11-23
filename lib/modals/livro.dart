import 'package:leitor_ebooks/modals/comentario.dart';
import 'package:leitor_ebooks/modals/curtida.dart';
import 'package:leitor_ebooks/modals/usuario_model.dart';
import 'package:mobx/mobx.dart';
import 'currency_helper.dart';
import 'escritor_model.dart';

part 'livro.g.dart';

class LivrosModel = _LivrosModelBase with _$LivrosModel;

abstract class _LivrosModelBase with Store {
  /* ────────────────────
     Campos principais
  ──────────────────── */
  @observable
  int? id;
  @observable
  String? title;
  @observable
  String? description;
  @observable
  String? coverUrl;
  @observable
  String? downloadUrl;

  @observable
  bool? isPremium;
  @observable
  bool? isFree;
  @observable
  int? preco; // centavos
  @observable
  String? codigoMoeda; // ISO‑4217

  @observable
  int? categoryId;
  @observable
  String? categoria;
  @observable
  String? idioma;
  @observable
  String? regiao;
  @observable
  DateTime? criadoEm;

  /* ────────────────────
     Relacionamentos
  ──────────────────── */
  @observable
  EscritorModel? author;
  @observable
  UsuarioModel? usuario;

  @observable
  int? qtdCurtidas;
  @observable
  int? qtdComentarios;

  @observable
  List<CurtidaModel> listCurtidas = [];
  @observable
  List<ComentarioModel> listComentarios = [];

  /* ────────────────────
     Estados locais (UI)
  ──────────────────── */
  @observable
  bool favorite = false;
  @observable
  bool loading = false;
  @observable
  String? localDirectory;
  @observable
  bool? isDownloadOk;

  _LivrosModelBase();

  /* ────────────────────
     FROM JSON
  ──────────────────── */
  _LivrosModelBase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    coverUrl = json['cover_url'];
    downloadUrl = json['download_url'];

    isPremium = json['is_premium'];
    isFree = json['is_free'];
    preco = json['preco'];
    codigoMoeda = json['codigo_moeda'];
    categoria = json['categoria'];
    categoryId = json['category_id'];
    idioma = json['idioma'];
    regiao = json['regiao'];
    criadoEm = DateTime.tryParse(json['criado_em'] ?? '');

    author = EscritorModel.fromJson(json['author']);
    usuario =
        json['usuario'] != null ? UsuarioModel.fromJson(json['usuario']) : null;

    qtdCurtidas = _toInt(json['qtd_curtidas']);
    qtdComentarios = _toInt(json['qtd_comentarios']);

    listCurtidas = (json['usuarios_curtem'] as List? ?? [])
        .map((e) => CurtidaModel.fromJson(e))
        .toList();

    listComentarios = (json['list_comentarios'] as List? ?? [])
        .map((e) => ComentarioModel.fromJson(e))
        .toList();
  }

  /* ────────────────────
     Preço formatado
  ──────────────────── */
  static const _regiaoToMoeda = {
    'brasil': 'BRL',
    'eua': 'USD',
    'usa': 'USD',
    'united states': 'USD',
    'espanha': 'EUR',
    'alemanha': 'EUR',
    'japao': 'JPY',
    'japão': 'JPY',
  };

  @computed
  String get precoFormatado {
    if (preco == null || preco == 0 || isFree == true) return 'Grátis';
    final valor = preco! / 100;

    final code = (codigoMoeda?.isNotEmpty ?? false)
        ? codigoMoeda!
        : (_regiaoToMoeda[regiao?.toLowerCase() ?? ''] ?? 'BRL');

    return formatarMoeda(valor, code);
  }

  /* ────────────────────
     Helpers & Ações
  ──────────────────── */
  int? _toInt(dynamic v) => v == null ? null : int.tryParse(v.toString());

  @action
  void setFavorite(bool v) => favorite = v;
  @action
  void setLoading(bool v) => loading = v;
  @action
  void setLocalDirectory(String? v) => localDirectory = v;
  @action
  void setIsDownloadOk(bool? v) => isDownloadOk = v;
}
