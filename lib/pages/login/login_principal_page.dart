import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_loading_widget.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:provider/provider.dart';
import '../../globals/store/globals_store.dart';
import '../../globals/theme_controller.dart';
import 'login_principal_functions.dart';
import 'widget/login_principal_widget.dart';

class LoginPrincipalPage extends StatefulWidget {
  const LoginPrincipalPage({super.key});

  @override
  State<LoginPrincipalPage> createState() => _LoginPrincipalPageState();
}

class _LoginPrincipalPageState extends State<LoginPrincipalPage> {
  late GlobalsThemeVar globalsThemeVar;
  late GlobalsStore globalsStore;
  late LoginPrincipalFunctions loginPrincipalFunctions;

  bool carregando = true;
  bool entrouIniciaPage = false;

  @override
  void didChangeDependencies() async {
    globalsStore = Provider.of<GlobalsStore>(context);
    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    loginPrincipalFunctions = Provider.of<LoginPrincipalFunctions>(context);

    if (!entrouIniciaPage) {
      _iniciaPage();
    }

    super.didChangeDependencies();
  }

  Future _iniciaPage() async {
    entrouIniciaPage = true;
    await loginPrincipalFunctions.loginPrincipalFunctionsPrincipal(context);
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
                      child: LoginPrincipalWidget(context)
                          .loginPrincipalWidgetPrincipal(context)),
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
