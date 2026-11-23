import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/controllers/user_infos.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/globals/store/globals_store.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/detalhes_page_widget.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/store/detalhes_livro_store.dart';
import 'package:provider/provider.dart';
import '../../globals/theme_controller.dart';
import 'detalhes_page_functions.dart';

class DetalhesPage extends StatefulWidget {
  final String livroId;

  const DetalhesPage({super.key, required this.livroId});

  @override
  State<DetalhesPage> createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  late GlobalsThemeVar globalsThemeVar;
  late DetalhesPrincipalFunctions detalhesPrincipalFunctions;
  late LivroDetalhesStore livroDetalhesStore;
  late GlobalsStore globalsStore;
  late UserInfos userInfos;

  bool carregando = true;
  bool _jaInicializou = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    detalhesPrincipalFunctions =
        Provider.of<DetalhesPrincipalFunctions>(context);
    globalsStore = Provider.of<GlobalsStore>(context);
    livroDetalhesStore = Provider.of<LivroDetalhesStore>(context);
    userInfos = Provider.of<UserInfos>(context);

    if (!_jaInicializou) {
      _jaInicializou = true;
      _iniciaPage();
    }
  }

  Future<void> _iniciaPage() async {
    setState(() => carregando = true);
    await detalhesPrincipalFunctions.detalhesFunctionPrincipal(
      globalsStore,
      livroDetalhesStore,
      widget.livroId,
    );
    if (!mounted) return;
    setState(() => carregando = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
      body: RefreshIndicator(
        color: globalsThemeVar.iGlobalsColors.primaryColor,
        onRefresh: _iniciaPage,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: carregando
                  ? GlobalsWidgets(context).loading()
                  : DetalhesLivroWidget(context).detalhesPerfilPrincipal(
                      livroDetalhesStore,
                      detalhesPrincipalFunctions,
                      globalsThemeVar,
                      userInfos),
            ),
            Observer(builder: (_) {
              return Visibility(
                visible: globalsStore.loading,
                child: GlobalsWidgets(context).loading(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
