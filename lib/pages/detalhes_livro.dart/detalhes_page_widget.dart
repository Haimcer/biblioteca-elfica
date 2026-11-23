import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/controllers/user_infos.dart';
import 'package:leitor_ebooks/globals/globals_functions.dart';
import 'package:leitor_ebooks/globals/globals_local_storage.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/globals/globals_users_widget.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/globals/globlas_alert.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:leitor_ebooks/modals/livro.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/detalhes_page_functions.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/store/detalhes_livro_store.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class DetalhesLivroWidget {
  DetalhesLivroWidget(this.context);
  final BuildContext context;

  Widget detalhesPerfilPrincipal(
      LivroDetalhesStore livroDetalhesStore,
      DetalhesPrincipalFunctions detalhesPrincipalFunctions,
      GlobalsThemeVar globalsThemeVar,
      UserInfos userInfos) {
    final size = MediaQuery.of(context).size;
    var celular = getNumeroDeLinhas(context);
    List<Widget> usuarios = [];
    double margin = 0;
    for (var element in livroDetalhesStore.livro!.listCurtidas!) {
      if (usuarios.length >= 5) {
        usuarios.add(Container(
            height: 15,
            width: 15,
            margin: EdgeInsets.only(left: margin),
            decoration: BoxDecoration(
                color: globalsThemeVar.iGlobalsColors.tertiaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white)),
            child: Center(
              child: Text(
                '${livroDetalhesStore.livro!.qtdCurtidas} +',
                style: TextStyle(
                  color: globalsThemeVar.iGlobalsColors.textColorForte,
                  fontSize: GlobalsSizes(context).sizeText - 2,
                  fontWeight: GlobalsStyles(context).negritoFont,
                ),
              ),
            )));
        break;
      } else {
        usuarios.add(Container(
            height: 15,
            width: 15,
            margin: EdgeInsets.only(left: margin),
            decoration: BoxDecoration(
                color: globalsThemeVar.iGlobalsColors.tertiaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white)),
            child: GlobalsUsersWidget(context).imgPerfilUser(
                imageUser: element.foto,
                otherImgae: true,
                nomeUsuario: element.nomeUsuario)));

        margin = margin + 10;
      }
    }

    return Observer(builder: (_) {
      return Expanded(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(GlobalsSizes(context).marginSpaceSize),
              child: ListView(
                children: [
                  Row(
                    children: [
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: globalsThemeVar
                                .iGlobalsColors.textColorPrimaryInverse,
                            size: GlobalsSizes(context).sizeTextMedio,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: celular > 3
                        ? EdgeInsets.symmetric(horizontal: size.width * 0.25)
                        : EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    height:
                        celular > 3 ? size.height * 0.80 : size.height * 0.50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(GlobalsSizes(context).borderSize),
                        topRight:
                            Radius.circular(GlobalsSizes(context).borderSize),
                        bottomLeft:
                            Radius.circular(GlobalsSizes(context).borderSize),
                        bottomRight:
                            Radius.circular(GlobalsSizes(context).borderSize),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: livroDetalhesStore.livro!.coverUrl ?? '',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          width: double.infinity,
                          height: size.height * 0.35,
                          color: Colors.grey[300],
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          height: size.height * 0.35,
                          child: Icon(Icons.broken_image,
                              size: 48, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: celular > 3
                              ? EdgeInsets.symmetric(
                                  horizontal: size.width * 0.25)
                              : EdgeInsets.symmetric(
                                  horizontal: size.width * 0.05),
                          child: Column(
                            children: [
                              Text(
                                livroDetalhesStore.livro!.title ?? '-',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: GlobalsStyles(context).styleTitle,
                              ),
                              SizedBox(height: 4),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      "por:",
                                      style: GlobalsStyles(context).styleMenor,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Flexible(
                                      flex: 0,
                                      child: GlobalsUsersWidget(context)
                                          .imgRedondaUser(
                                              GlobalsSizes(context)
                                                  .sizeTextMedio,
                                              networkImage: livroDetalhesStore
                                                  .livro?.author?.foto,
                                              nome: livroDetalhesStore
                                                  .livro?.author?.nomeCompleto)),
                                  const SizedBox(width: 5),
                                  Flexible(
                                    flex: 0,
                                    child: Text(
                                      livroDetalhesStore
                                              .livro!.author?.nomeCompleto ??
                                          '-',
                                      style: GlobalsStyles(context).styleMenor,
                                    ),
                                  ),
                                  Flexible(
                                    flex: 10,
                                    child: Text(
                                      "",
                                      style: GlobalsStyles(context).styleMenor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                livroDetalhesStore.livro!.description ?? '-',
                                style: GlobalsStyles(context).styleMedio,
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      livroDetalhesStore.livro?.listCurtidas
                                                  ?.any((curtida) =>
                                                      curtida.usuarioId ==
                                                      userInfos.usuario.id) ??
                                              false
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: livroDetalhesStore
                                                  .livro?.listCurtidas
                                                  ?.any((curtida) =>
                                                      curtida.usuarioId ==
                                                      userInfos.usuario.id) ??
                                              false
                                          ? Colors.red
                                          : globalsThemeVar.iGlobalsColors
                                              .textColorPrimaryInverse,
                                    ),
                                    onPressed: () async {
                                      await livroDetalhesStore
                                          .alternarCurtida();
                                    },
                                  ),
                                  Stack(
                                    children: usuarios,
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      livroDetalhesStore.livro!.favorite
                                          ? Icons.bookmark
                                          : Icons.bookmark_add_outlined,
                                      color: livroDetalhesStore.livro!.favorite
                                          ? Colors.red
                                          : globalsThemeVar.iGlobalsColors
                                              .textColorPrimaryInverse,
                                    ),
                                    onPressed: () async {
                                      if (livroDetalhesStore.livro!.favorite) {
                                        livroDetalhesStore.livro!
                                            .setFavorite(false);
                                        detalhesPrincipalFunctions.listFavorite
                                            .remove(livroDetalhesStore.livro!.id
                                                .toString());
                                        await GlobalsLocalStorage().setFavorite(
                                            listFavorite:
                                                detalhesPrincipalFunctions
                                                    .listFavorite);
                                      } else {
                                        livroDetalhesStore.livro!
                                            .setFavorite(true);
                                        detalhesPrincipalFunctions.listFavorite
                                            .add(livroDetalhesStore.livro!.id
                                                .toString());
                                        await GlobalsLocalStorage().setFavorite(
                                            listFavorite:
                                                detalhesPrincipalFunctions
                                                    .listFavorite);
                                      }
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.download,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () async {
                                      if (livroDetalhesStore
                                              .livro!.isDownloadOk ==
                                          false) {
                                        if (await GlobalsFunctions()
                                            .verificaConexao()) {
                                          GlobalsAlert(context)
                                              .alertInternet(context);
                                          return;
                                        }
                                      }
                                      livroDetalhesStore.livro!
                                          .setLoading(true);
                                      await detalhesPrincipalFunctions.download(
                                          livroDetalhesStore.livro!, context);

                                      VocsyEpub.setConfig(
                                        themeColor: globalsThemeVar
                                            .iGlobalsColors.primaryColor,
                                        identifier: 'isbook',
                                        scrollDirection:
                                            EpubScrollDirection.ALLDIRECTIONS,
                                        allowSharing: true,
                                        enableTts: true,
                                        nightMode:
                                            globalsThemeVar.currentThemeMode ==
                                                    ThemeMode.light
                                                ? false
                                                : true,
                                      );

                                      if (livroDetalhesStore
                                              .livro!.isDownloadOk ??
                                          false) {
                                        VocsyEpub.open(
                                          livroDetalhesStore
                                                  .livro!.localDirectory ??
                                              '',
                                          lastLocation: null,
                                        );
                                      }

                                      // livroDetalhesStore.livro!.setLoading(false);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                            margin: celular > 3
                                ? EdgeInsets.symmetric(
                                    horizontal: size.width * 0.15)
                                : EdgeInsets.symmetric(
                                    horizontal: size.width * 0.005),
                            child: Column(
                              children: [
                                Text(
                                  'Comentários (${livroDetalhesStore.livro!.qtdComentarios ?? 0})',
                                  style: GlobalsStyles(context).styleMedio,
                                ),
                                const SizedBox(height: 8),
                                if ((livroDetalhesStore
                                        .livro!.listComentarios?.isNotEmpty ??
                                    false))
                                  ...livroDetalhesStore.livro!.listComentarios!
                                      .map((comentario) => _buildComentarioTile(
                                          context, comentario)),
                                if (livroDetalhesStore.livro!.listComentarios ==
                                        null ||
                                    livroDetalhesStore
                                        .livro!.listComentarios!.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                    child: Center(
                                      child: Text(
                                        'Nenhum comentário ainda.',
                                        style:
                                            GlobalsStyles(context).styleMenor,
                                      ),
                                    ),
                                  ),
                                _buildInputComentario(livroDetalhesStore,
                                    livroDetalhesStore.livro!, globalsThemeVar),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (livroDetalhesStore.livro!.loading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                  child: Center(
                    child: GlobalsWidgets(context).loading(),
                  ),
                ),
              )
          ],
        ),
      );
    });
  }

  Widget _buildComentarioTile(context, comentario) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundImage: comentario.foto != null && comentario.foto!.isNotEmpty
            ? CachedNetworkImageProvider(comentario.foto!)
            : null,
        backgroundColor: Colors.grey[300],
        child: comentario.foto == null || comentario.foto!.isEmpty
            ? Icon(Icons.person, color: Colors.white)
            : null,
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              comentario.nomeUsuario ?? 'Anônimo',
              style: GlobalsStyles(context).styleMenor,
              overflow:
                  TextOverflow.ellipsis, // 👈 corta se nome for muito grande
            ),
          ),
          Text(
            comentario.criadoEm != null
                ? GlobalsFunctions().formataDataComentario(comentario.criadoEm!)
                : '',
            style: GlobalsStyles(context).styleMenor,
            textAlign: TextAlign.end, // 👈 garante que fique no finalzinho
          ),
        ],
      ),
      subtitle: Text(
        comentario.mensagem ?? '-',
        style: GlobalsStyles(context).styleMedio,
      ),
    );
  }

  Widget _buildInputComentario(LivroDetalhesStore livroDetalhesStore,
      LivrosModel livro, GlobalsThemeVar globalsThemeVar) {
    var celular = getNumeroDeLinhas(context);
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        children: [
          Expanded(
            child: Observer(builder: (_) {
              return TextFormField(
                controller: livroDetalhesStore.comentarioController,
                maxLines: celular > 3 ? 2 : 3,
                cursorColor: globalsThemeVar.iGlobalsColors.primaryColor,
                style: GlobalsStyles(context).styleMedio,
                decoration: InputDecoration(
                  hintText: 'Digite um comentário...',
                  hintStyle: GlobalsStyles(context).styleMedio,
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: globalsThemeVar.iGlobalsColors
                          .textColorPrimaryInverse, // Cor da borda inferior quando não focado
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: globalsThemeVar.iGlobalsColors
                          .primaryColor, // Cor da borda inferior quando focado
                      width: 2.0,
                    ),
                  ),
                ),
              );
            }),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              color: globalsThemeVar.iGlobalsColors.primaryColor,
            ),
            onPressed: () => livroDetalhesStore.comentar(),
          )
        ],
      ),
    );
  }
}
