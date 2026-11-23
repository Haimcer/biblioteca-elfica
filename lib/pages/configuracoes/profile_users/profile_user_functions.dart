import 'package:flutter/material.dart';
import 'package:leitor_ebooks/modals/escritor_model.dart';
import 'package:leitor_ebooks/modals/livro.dart';
import 'package:leitor_ebooks/modals/usuario_model.dart';
import 'package:leitor_ebooks/request/escritores/get_escritor.dart';
import 'package:leitor_ebooks/request/usuarios/get_usuario_por_id.dart';
import 'store/profile_user_store.dart';

class ProfileUserFunctions {
  final BuildContext context;

  ProfileUserFunctions(this.context);

  Future<void> carregarPerfil(
      ProfileUserStore store, String id, String tipo) async {
    store.clear();
    if (tipo == 'escritor') {
      await fetchPerfilEscritor(store, id);
    } else {
      await fetchPerfilUsuario(store, id);
    }
  }

  Future fetchPerfilUsuario(ProfileUserStore store, String id) async {
    try {
      print('vim aqui');
      store.setLoading(true);

      // 1. Buscar informações básicas do usuário
      final usuarioInfo = await GetUsuarioPorIdRequest(context).getUsuario(id);

      UsuarioModel usuario = UsuarioModel();
      if (usuarioInfo != null) {
        usuario = UsuarioModel.fromJson(usuarioInfo);
        print(usuario.nomeUsuario);
        store.setNomeUsuario(usuario.nomeUsuario ?? '-');
        store.setFotoUsuario(usuario.foto ?? '');
      }

      // 2. Buscar seguidores e seguindo

      store.setSeguidores(usuario.seguidores.length);
      store.setSeguindo(usuario.seguindo.length);
      store.setQtdPosts(usuario.curtidores.length);

      // 3. Buscar livros do usuário
      final livrosUsuario = usuario.livrosCurtidos;

      if (livrosUsuario.isNotEmpty) {
        store.setLivrosRecentes(List.from(livrosUsuario));

        // Considera "populares" como os livros ordenados por mais curtidos
        final populares = List<LivrosModel>.from(livrosUsuario);
        populares
            .sort((a, b) => (b.qtdCurtidas ?? 0).compareTo(a.qtdCurtidas ?? 0));
        store.setLivrosPopulares(populares);
      }
    } catch (e) {
      debugPrint('Erro ao carregar perfil: \$e');
    } finally {
      store.setLoading(false);
    }
  }

  Future fetchPerfilEscritor(ProfileUserStore store, String id) async {
    try {
      print('vim aqui');
      store.setLoading(true);

      // 1. Buscar informações básicas do usuário
      final usuarioInfo = await GetEscritorRequest(context).getEscritor(id);

      EscritorModel escritor = EscritorModel();
      if (usuarioInfo != null) {
        escritor = EscritorModel.fromJson(usuarioInfo['escritor']);
        print(escritor.nomeCompleto);
        store.setNomeUsuario(escritor.nomeCompleto ?? '-');
        store.setFotoUsuario(escritor.foto ?? '');
      }

      // 2. Buscar seguidores e seguindo

      store.setSeguidores(escritor.seguidores.length);
      store.setSeguindo(escritor.seguindo.length);
      store.setQtdPosts(escritor.curtidores.length);

      // 3. Buscar livros do usuário
      final livrosUsuario = escritor.livrosPublicados;

      if (livrosUsuario.isNotEmpty) {
        store.setLivrosRecentes(List.from(livrosUsuario));

        // Considera "populares" como os livros ordenados por mais curtidos
        final populares = List<LivrosModel>.from(livrosUsuario);
        populares
            .sort((a, b) => (b.qtdCurtidas ?? 0).compareTo(a.qtdCurtidas ?? 0));
        store.setLivrosPopulares(populares);
      }
    } catch (e) {
      debugPrint('Erro ao carregar perfil: \$e');
    } finally {
      store.setLoading(false);
    }
  }
}
