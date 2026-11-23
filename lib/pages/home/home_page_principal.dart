import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/main.dart';
import 'package:leitor_ebooks/pages/home/home_page_widget.dart';
import 'package:leitor_ebooks/pages/home/store/home_store.dart';
import 'package:provider/provider.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import 'home_page_functions.dart';

class HomePage extends StatefulWidget {
  final String categoriaId;

  const HomePage({super.key, required this.categoriaId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  late GlobalsThemeVar globalsThemeVar;
  late HomePrincipalFunctions homePrincipalFunctions;
  late GlobalsStore globalsStore;
  late HomeStore homeStore;

  bool carregando = true;
  bool _jaInicializou = false;

  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    homePrincipalFunctions = Provider.of<HomePrincipalFunctions>(context);
    globalsStore = Provider.of<GlobalsStore>(context);
    homeStore = Provider.of<HomeStore>(context);

    if (!_jaInicializou) {
      _jaInicializou = true;
      _iniciaPage();
    }

    // 👇 Inscreve no RouteObserver

    routeObserver.subscribe(
        this, ModalRoute.of(context)! as PageRoute<dynamic>);
  }

  @override
  void dispose() {
    // 👇 Desinscreve no dispose
    routeObserver.unsubscribe(this);
    _scrollController.dispose();
    super.dispose();
  }

  // 🔥 Chamado quando volta da outra página
  @override
  void didPopNext() {
    super.didPopNext();
    _iniciaPage();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.categoriaId != widget.categoriaId) {
      _iniciaPage(); // Atualiza a tela ao trocar categoria
    }
  }

  Future<void> _iniciaPage() async {
    setState(() => carregando = true);
    homeStore.setListModelMobXClear();
    await homePrincipalFunctions.homeFunctionPrincipal(
      context,
      globalsStore,
      homeStore,
      widget.categoriaId,
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
                  : HomeWidget(context)
                      .homePerfilPrincipal(context, _scrollController),
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
