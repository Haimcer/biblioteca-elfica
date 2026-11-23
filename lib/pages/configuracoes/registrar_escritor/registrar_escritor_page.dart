import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_loading_widget.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/store/globals_store.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:leitor_ebooks/modals/escritor_model.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/registrar_escritor_widget.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/store/registrar_escritor_store.dart';
import 'package:provider/provider.dart';

import 'registrar_escritor_functions.dart';

// ignore: must_be_immutable
class CadastroEscritorPage extends StatefulWidget {
  CadastroEscritorPage({this.escritorModelEscAux, super.key});

  EscritorModel? escritorModelEscAux;

  @override
  State<CadastroEscritorPage> createState() => _CadastroEscritorPageState();
}

class _CadastroEscritorPageState extends State<CadastroEscritorPage> {
  late CadastroEscritorFunctions cadastroEscritorFunctions;
  late GlobalsThemeVar globalsThemeVar;
  late GlobalsStore globalsStore;
  late ResgistrarEscritorStore resgistrarEscritorStore;

  bool carregando = true;
  bool entrouIniciaPage = false;

  @override
  void didChangeDependencies() {
    cadastroEscritorFunctions = Provider.of<CadastroEscritorFunctions>(context);
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    resgistrarEscritorStore = Provider.of<ResgistrarEscritorStore>(context);

    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;

    await cadastroEscritorFunctions.escritorFunctionsPrincipal(
        widget.escritorModelEscAux, resgistrarEscritorStore);

    if (!mounted) return;
    setState(() {
      //print('entrou');
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GlobalsStylesFont().fontName),
      home: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          /*decoration: BoxDecoration(
              gradient: globalsThemeVar.iGlobalsColors.colorGradiente,
              ),*/
          child: Stack(
            children: [
              carregando
                  ? GlobalsLoadingWidget(context).loagingPageInicio(
                      MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width)
                  : Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                      // width: MediaQuery.of(context).size.width,
                      child: CadastroEscritorWidget(context)
                          .cadastroEscritorWidgetPrincipal(context)),
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
