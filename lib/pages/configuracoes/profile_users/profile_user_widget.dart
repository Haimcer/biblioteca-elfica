import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leitor_ebooks/globals/globals_users_widget.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:leitor_ebooks/modals/livro.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/detalhes_page_principal.dart';
import 'package:leitor_ebooks/pages/configuracoes/profile_users/profile_user_functions.dart';
import 'package:leitor_ebooks/pages/configuracoes/profile_users/store/profile_user_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class ProfileUserWidget {
  ProfileUserWidget(this.context, this.tipo);
  final BuildContext context;
  final String tipo;

  Widget profileUserPrincipal(ProfileUserStore store,
      ProfileUserFunctions functions, TabController tabController) {
    final size = MediaQuery.of(context).size;

    var celular = getNumeroDeLinhas(context);
    return Observer(
      builder: (_) => store.loading
          ? GlobalsWidgets(context).loading()
          : SizedBox(
              height: size.height,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: celular > 3
                    ? EdgeInsets.symmetric(horizontal: size.width * 0.15)
                    : EdgeInsets.symmetric(horizontal: size.width * 0.005),
                children: [
                  _buildHeader(store),
                  const SizedBox(height: 16),
                  // _buildCounts(store),
                  // const SizedBox(height: 16),
                  Text(
                    tipo == 'escritor'
                        ? 'Livros Publicados'
                        : 'Livros Curtidos',
                    style: GlobalsStyles(context).styleSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  _buildTabs(store),
                ],
              ),
            ),
    );
  }

  Widget _buildHeader(ProfileUserStore store) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final celular = getNumeroDeLinhas(context);
    return SizedBox(
      height:
          celular > 3 ? 250 : 200, // ajuste a altura que você quiser pro header
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 1) imagem de fundo
          if (store.fotoUsuario != null && store.fotoUsuario!.isNotEmpty)
            CachedNetworkImage(
              imageUrl: store.fotoUsuario!,
              fit: BoxFit.cover,
              errorWidget: (_, __, ___) => Container(color: Colors.grey[300]),
            )
          else
            Container(color: Colors.grey[300]),

          // 2) máscara escura
          Container(color: Colors.black.withOpacity(0.4)),

          // 3) seu conteúdo

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child: Column(
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
                Row(
                  children: [
                    // avatar
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: store.fotoUsuario != null &&
                              store.fotoUsuario!.isNotEmpty
                          ? CachedNetworkImageProvider(store.fotoUsuario!)
                          : null,
                      backgroundColor: Colors.grey[700],
                      child: store.fotoUsuario == null ||
                              store.fotoUsuario!.isEmpty
                          ? const Icon(Icons.person,
                              size: 40, color: Colors.white)
                          : null,
                    ),

                    const SizedBox(width: 16),

                    // nome + email
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(store.nomeUsuario ?? '-',
                              style: GlobalsStyles(context)
                                  .styleTitle
                                  .copyWith(color: Colors.white)),
                          const SizedBox(height: 4),
                          Text(store.emailUsuario ?? '-',
                              style: GlobalsStyles(context)
                                  .styleMenor
                                  .copyWith(color: Colors.white70)),
                        ],
                      ),
                    ),
                  ],
                ),
                _buildCounts(store)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCounts(ProfileUserStore store) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCountItem('Curtidas Recebidas', store.qtdPosts),
        _buildCountItem('Seguidores', store.seguidores),
        _buildCountItem('Seguindo', store.seguindo),
      ],
    );
  }

  Widget _buildCountItem(String label, int value) {
    return Column(
      children: [
        Text('$value', style: GlobalsStyles(context).styleTitle),
        Text(label, style: GlobalsStyles(context).styleMenor),
      ],
    );
  }

  Widget _buildTabs(ProfileUserStore store) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            indicatorColor: globalsThemeVar.iGlobalsColors.primaryColor,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.bookOpen,
                        size: GlobalsSizes(context).sizeSubtitulo,
                        color: globalsThemeVar.iGlobalsColors.primaryColor),
                    const SizedBox(width: 8),
                    Text('Recentes',
                        style: GlobalsStyles(context).styleSubtitle),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.star,
                        size: GlobalsSizes(context).sizeSubtitulo,
                        color: globalsThemeVar.iGlobalsColors.primaryColor),
                    const SizedBox(width: 8),
                    Text('Populares',
                        style: GlobalsStyles(context).styleSubtitle),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height,
            child: TabBarView(
              children: [
                _buildLivrosList(store.livrosRecentes),
                _buildLivrosList(store.livrosPopulares),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLivrosList(List<LivrosModel> livros) {
    final tipoTela = getNumeroDeLinhas(context);

    return livros.isEmpty
        ? GlobalsWidgets(context).imgEmpty()
        : GridView.builder(
            padding: EdgeInsets.all(GlobalsSizes(context).marginSpaceSize),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: tipoTela < 3 ? 2 : 5,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 5 / 8,
            ),
            itemCount: livros.length,
            itemBuilder: (context, index) {
              return _buildLivroCard(livros[index], context);
            },
          );
  }

  Widget _buildLivroCard(LivrosModel livro, BuildContext contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

    return Observer(builder: (_) {
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
                      Row(
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
                                    style: GlobalsStyles(context).styleMenor,
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
                                    style: GlobalsStyles(context).styleMenor,
                                  ),
                                ],
                              )),
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
