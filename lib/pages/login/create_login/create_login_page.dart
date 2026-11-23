import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_loading_widget.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/store/globals_store.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:provider/provider.dart';

import 'create_login_widget.dart';

class CreateLoginPage extends StatefulWidget {
  const CreateLoginPage({super.key});

  @override
  State<CreateLoginPage> createState() => _CreateLoginPageState();
}

class _CreateLoginPageState extends State<CreateLoginPage> {
  late GlobalsThemeVar globalsThemeVar;
  late GlobalsStore globalsStore;

  bool carregando = true;
  bool entrouIniciaPage = false;

  @override
  void didChangeDependencies() async {
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
      print('entrou');
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: GlobalsStylesFont().fontName),
      home: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: globalsThemeVar.iGlobalsColors.backgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // decoration: BoxDecoration(
          //   gradient: globalsThemeVar.iGlobalsColors.colorGradiente
          //   ),
          child: Stack(
            children: [
              carregando
                  ? GlobalsLoadingWidget(context).loadingPrincipal()
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: CreateLoginWidget(context)
                          .createLoginWidgetPrincipal(context)),
              Observer(builder: (_) {
                return Visibility(
                    visible: globalsStore.loading,
                    child: GlobalsLoadingWidget(context).loadingPrincipal());
              }),
            ],
          ),
        ),
      ),
    );
  }
}
