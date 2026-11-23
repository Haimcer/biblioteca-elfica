import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_loading_widget.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/globals/store/globals_store.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:leitor_ebooks/pages/configuracoes/area_escritor/area_escritor_widget.dart';
import 'package:provider/provider.dart';

class WriterAreaPage extends StatefulWidget {
  const WriterAreaPage({Key? key}) : super(key: key);

  @override
  _WriterAreaPageState createState() => _WriterAreaPageState();
}

class _WriterAreaPageState extends State<WriterAreaPage> {
  final ScrollController _templateController = ScrollController();
  late GlobalsThemeVar globalsThemeVar;
  late GlobalsStore globalsStore;

  bool carregando = true;
  bool entrouIniciaPage = false;

  @override
  void didChangeDependencies() {
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;

    if (!mounted) return;
    setState(() {
      //print('entrou');
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);

    return Scaffold(
      backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: globalsThemeVar.iGlobalsColors.primaryColor,
          onRefresh: _iniciaPage,
          child: Stack(
            children: [
              carregando
                  ? GlobalsWidgets(context).loading()
                  : AreaEscritorWidget(context, _templateController)
                      .areaEscritoWidgetPrincipal(context),
              Observer(builder: (_) {
                return Visibility(
                    visible: globalsStore.loading,
                    child: GlobalsLoadingWidget(context).loagingPageInicio(
                        MediaQuery.of(context).size.height,
                        MediaQuery.of(context).size.width));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
