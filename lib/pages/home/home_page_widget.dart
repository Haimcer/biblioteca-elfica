import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leitor_ebooks/globals/globals_local_storage.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/globals/globals_users_widget.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/detalhes_page_principal.dart';
import 'package:leitor_ebooks/pages/home/home_page_functions.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import 'package:provider/provider.dart';
import '../../globals/globals_vars.dart';
import '../../globals/theme_controller.dart';
import '../../modals/livro.dart';

class HomeWidget {
  HomeWidget(this.context);
  BuildContext context;

  Widget homePerfilPrincipal(
      BuildContext contextAux, ScrollController scrollController) {
    final homeStore = Provider.of<HomeStore>(context);
    final tipoTela = getNumeroDeLinhas(contextAux);
    return Column(
      children: [
        Expanded(
          child: homeStore.listModelMobX.isEmpty
              ? GlobalsWidgets(context).imgEmpty()
              : GridView.builder(
                  controller: scrollController,
                  padding:
                      EdgeInsets.all(GlobalsSizes(contextAux).marginSpaceSize),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: tipoTela < 3 ? 2 : 5,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 5 / 8,
                  ),
                  itemCount: homeStore.listModelMobX.length,
                  itemBuilder: (context, index) {
                    return _buildLivroCard(
                        homeStore.listModelMobX[index], contextAux);
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildLivroCard(LivrosModel livro, BuildContext contextAux) {
    final homePrincipalFunctions = Provider.of<HomePrincipalFunctions>(context);
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

    return Observer(builder: (_) {
      livro.setIsDownloadOk(
          homePrincipalFunctions.listDownloads.contains(livro.id.toString()));
      livro.setFavorite(
          homePrincipalFunctions.listFavorite.contains(livro.id.toString()));
      return IgnorePointer(
        ignoring: livro.loading,
        child: GestureDetector(
          onTap: () async {
            Navigator.push(
              contextAux,
              MaterialPageRoute(
                  builder: (_) => DetalhesPage(
                        livroId: livro.id.toString(),
                      )),
            );

            // livro.setLoading(false);
          },
          child: Card(
            color: globalsThemeVar.iGlobalsColors.tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(GlobalsSizes(contextAux).borderSize),
            ),
            elevation: 2.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Imagem carregada da rede
                      ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                GlobalsSizes(contextAux).borderSize),
                            topRight: Radius.circular(
                                GlobalsSizes(contextAux).borderSize),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: livro.coverUrl ?? '',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorWidget: (context, url, error) {
                              return GlobalsWidgets(context).loading(size: 25);
                            },
                          )),
                      // Máscara escura
                      Opacity(
                        opacity: livro.loading ? 0.5 : 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                  GlobalsSizes(contextAux).borderSize),
                              topRight: Radius.circular(
                                  GlobalsSizes(contextAux).borderSize),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          left: GlobalsSizes(contextAux).marginSpaceSize / 2,
                          right: GlobalsSizes(contextAux).marginSpaceSize / 2,
                          top: GlobalsSizes(contextAux).marginSpaceSize / 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              FontAwesomeIcons.circleCheck,
                              color: livro.isDownloadOk ?? false
                                  ? Colors.green.withOpacity(1)
                                  : Colors.green.withOpacity(0),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (livro.favorite) {
                                  livro.setFavorite(false);
                                  homePrincipalFunctions.listFavorite
                                      .remove(livro.id.toString());
                                  await GlobalsLocalStorage().setFavorite(
                                      listFavorite:
                                          homePrincipalFunctions.listFavorite);
                                } else {
                                  livro.setFavorite(true);
                                  homePrincipalFunctions.listFavorite
                                      .add(livro.id.toString());
                                  await GlobalsLocalStorage().setFavorite(
                                      listFavorite:
                                          homePrincipalFunctions.listFavorite);
                                }
                              },
                              child: livro.favorite
                                  ? const Icon(
                                      FontAwesomeIcons.solidBookmark,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      FontAwesomeIcons.bookmark,
                                      color: globalsThemeVar
                                          .iGlobalsColors.textColorFraco,
                                    ),
                            ),
                          ],
                        ),
                      ),
                      // Indicador de progresso
                      livro.loading
                          ? Observer(
                              builder: (context) {
                                return GlobalsWidgets(context)
                                    .loading(size: 25);
                              },
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        livro.title ?? '',
                        style: GlobalsStyles(context).styleSubtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Flexible(
                            flex: 5,
                            child: GlobalsUsersWidget(context).imgNameUser(
                                GlobalsSizes(contextAux).sizeTextMedio,
                                networkImage: livro.author?.foto,
                                nome: livro.author?.nomeCompleto),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                              flex: 1,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    livro.precoFormatado,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GlobalsStyles(context).styleMedio,
                                  ),
                                ],
                              )),
                          Flexible(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.favorite,
                                            color: globalsThemeVar
                                                .iGlobalsColors.textColorFraco,
                                            size: GlobalsSizes(contextAux)
                                                .sizeTextMedio),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${livro.qtdCurtidas}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              GlobalsStyles(context).styleMenor,
                                        ),
                                      ],
                                    )),
                                const SizedBox(width: 5),
                                Flexible(
                                    flex: 1,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(Icons.comment,
                                            color: globalsThemeVar
                                                .iGlobalsColors.textColorFraco,
                                            size: GlobalsSizes(contextAux)
                                                .sizeTextMedio),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${livro.qtdComentarios}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              GlobalsStyles(context).styleMenor,
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
