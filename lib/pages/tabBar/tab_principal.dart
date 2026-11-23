import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../globals/globals_functions.dart';
import '../../globals/globals_widgets.dart';
import '../../globals/globlas_alert.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import '../favorite/favorites_page_principal.dart';
import '../home/home_page_principal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ignore: must_be_immutable
class TabBarPrincipal extends StatefulWidget {
  TabBarPrincipal({super.key, required this.categoriaId});
  String categoriaId;
  @override
  State<TabBarPrincipal> createState() => _TabBarPrincipalState();
}

class _TabBarPrincipalState extends State<TabBarPrincipal> {
  late SharedPreferences prefs;
  late GlobalsThemeVar globalsThemeVar;
  bool entrouIniciaPage = false;
  bool carregando = true;

  @override
  void didChangeDependencies() {
    if (!entrouIniciaPage) {
      globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    if (await GlobalsFunctions().verificaConexao()) {
      GlobalsAlert(context).alertWarning(context, onTap: () {
        SystemNavigator.pop();
      },
          text:
              "Ops! Parece que você está sem conexão com a internet. \nPor favor, verifique sua conexão e tente novamente.");
      return null;
    }
    prefs = await SharedPreferences.getInstance();
    entrouIniciaPage = true;
    await _iniciaTheme();
  }

  Future _iniciaTheme() async {
    var brightness = SchedulerBinding.instance.window.platformBrightness;
    final int? temaApp = prefs.getInt('theme');
    if (!mounted) return;
    setState(() {
      if (temaApp == null) {
        globalsThemeVar.currentThemeMode =
            brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      } else {
        if (temaApp == 0) {
          globalsThemeVar.currentThemeMode = ThemeMode.light;
        } else {
          globalsThemeVar.currentThemeMode = ThemeMode.dark;
        }
      }

      globalsThemeVar.setIGlobalsColors();
      carregando = false;
    });
  }

  // Future<bool?> exibirMensagem() => GlobalsAlert(context).alertDesejaSair(
  //       context,
  //       title: 'Deseja mesmo sair ?',
  //       onTap: () {
  //         SystemNavigator.pop();
  //       },
  //     );

  @override
  Widget build(BuildContext context) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final globalsStore = Provider.of<GlobalsStore>(context);
    double appBarHeight = MediaQuery.of(context).size.height / 4;
    var celular = getNumeroDeLinhas(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: Observer(builder: (_) {
            return GlobalsWidgets(context).appBarDescTitulo(context,
                titulo: globalsStore.nomeCategoria);
          }),
        ),
        body: Column(
          children: [
            TabBar(
              isScrollable: celular > 3,
              indicatorColor: globalsThemeVar.iGlobalsColors.primaryColor,
              tabs: <Widget>[
                Tab(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.bookOpen,
                            size: GlobalsSizes(context).sizeSubtitulo,
                            color:
                                globalsThemeVar.iGlobalsColors.primaryColor),
                        const SizedBox(width: 8),
                        Text('Biblioteca',
                            style: GlobalsStyles(context).styleSubtitle),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.bookBookmark,
                            size: GlobalsSizes(context).sizeSubtitulo,
                            color:
                                globalsThemeVar.iGlobalsColors.primaryColor),
                        const SizedBox(width: 8),
                        Text('Marcados',
                            style: GlobalsStyles(context).styleSubtitle),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: <Widget>[
                  HomePage(
                    key: ValueKey(widget.categoriaId),
                    categoriaId: widget.categoriaId,
                  ),
                  const FavoritesPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
