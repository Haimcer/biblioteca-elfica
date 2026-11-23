import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_buttons.dart';
import 'package:leitor_ebooks/globals/globals_form.dart';
import 'package:leitor_ebooks/globals/store/globals_store.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:leitor_ebooks/pages/login/create_login/create_login_page.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../controllers/user_ids.dart';
import '../../../controllers/user_infos.dart';
import '../../../globals/globals_vars.dart';
import '../login_principal_functions.dart';
import '../store/login_principal_store.dart';

class LoginPrincipalWidget {
  BuildContext context;
  LoginPrincipalWidget(this.context);

  Widget loginPrincipalWidgetPrincipal(BuildContext contextAux) {
    return ListView(
      children: [
        SizedBox(
          height: GlobalsSizes(contextAux).marginSpaceSize * 2,
        ),
        _imgLogo(),
        SizedBox(
          height: GlobalsSizes(contextAux).marginSpaceSize * 2,
        ),
        _formLogin(contextAux),
        SizedBox(
          height: GlobalsSizes(contextAux).marginSpaceSize,
        ),
        _loginAdministrador(contextAux),
        SizedBox(
          height: GlobalsSizes(contextAux).marginSpaceSize,
        ),
      ],
    );
  }

  Widget _imgLogo() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalsSizes(context).marginSpaceSize * 2),
      child: Row(
        children: [
          Expanded(
            child: Image.asset(
              'assets/logo_principal.png',
              // fit: BoxFit.scaleDown,
            ),
          ),
        ],
      ),
    );
  }

  Widget _formLogin(BuildContext contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final loginPrincipalFunctions =
        Provider.of<LoginPrincipalFunctions>(context);
    final loginPrincipalStoreT = Provider.of<LoginPrincipalStore>(context);
    final loginPrincipalStoreF =
        Provider.of<LoginPrincipalStore>(context, listen: false);
    final userInfos = Provider.of<UserInfos>(contextAux, listen: false);
    final userIds = Provider.of<UserIds>(contextAux, listen: false);
    final globalsStore = Provider.of<GlobalsStore>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalsSizes(context).marginSpaceSize),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Email",
                style: TextStyle(
                    color: globalsThemeVar.iGlobalsColors.textColorForte,
                    fontSize: GlobalsSizes(contextAux).sizeTextMedio),
              ),
            ],
          ),
          SizedBox(
            height: GlobalsSizes(contextAux).marginSpaceSize / 2,
          ),
          GlobalsForm(contextAux).campoTextFieldTexto(
              loginPrincipalFunctions.controllerEmail, "Digite seu email"),
          SizedBox(
            height: GlobalsSizes(contextAux).marginSpaceSize,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Senha",
                style: TextStyle(
                    color: globalsThemeVar.iGlobalsColors.textColorForte,
                    fontSize: GlobalsSizes(contextAux).sizeTextMedio),
              ),
            ],
          ),
          SizedBox(
            height: GlobalsSizes(contextAux).marginSpaceSize / 2,
          ),
          Observer(builder: (_) {
            return GlobalsForm(contextAux).campoTextFieldTexto(
              loginPrincipalFunctions.controllerSenha,
              "Digite sua senha",
              obscureText: loginPrincipalStoreT.obscureTextSenha,
              suffixIcon: IconButton(
                  onPressed: () => loginPrincipalStoreF.setObscureTextSenha(),
                  icon: Icon(
                    loginPrincipalStoreT.obscureTextSenha
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeLowVision,
                    size: GlobalsSizes(context).sizeTextMedio,
                    color: globalsThemeVar.iGlobalsColors.textColorMedio,
                  )),
            );
          }),
          SizedBox(
            height: GlobalsSizes(contextAux).marginSpaceSize,
          ),
          GlobalsButtons(contextAux).buttonPrimaryGlobal(
              text: "Continue",
              colorButton: globalsThemeVar.iGlobalsColors.primaryColor,
              paddingV: GlobalsSizes(contextAux).marginSpaceSize * 0.5,
              onTap: () async {
                globalsStore.setLoading(true);
                await loginPrincipalFunctions.logarEmailPass(
                    contextAux, userIds, userInfos);
                globalsStore.setLoading(false);
              }),
          SizedBox(
            height: GlobalsSizes(contextAux).marginSpaceSize * 2,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                height: 1,
                color: globalsThemeVar.iGlobalsColors.textColorFraco,
              )),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: GlobalsSizes(contextAux).marginSpaceSize / 2),
                  child: Text(
                    'ou',
                    style: TextStyle(
                        color: globalsThemeVar.iGlobalsColors.textColorFraco,
                        fontWeight: FontWeight.bold,
                        fontSize: GlobalsSizes(contextAux).sizeTextMedio),
                  )),
              Expanded(
                  child: Container(
                height: 1,
                color: globalsThemeVar.iGlobalsColors.textColorFraco,
              )),
            ],
          ),
          SizedBox(height: GlobalsSizes(contextAux).marginSpaceSize),
          GlobalsButtons(contextAux).buttonPrimaryGlobal(
            text: "Continue com Google",
            colorBorder: globalsThemeVar.iGlobalsColors.textColorMedio,
            colorText: globalsThemeVar.iGlobalsColors.textColorMedio,
            isBorder: true,
            prefixWid: Row(
              children: [
                Image.asset(
                  'assets/icons/google_logo.png',
                  height: GlobalsSizes(contextAux).sizeTextMedio * 2,
                  fit: BoxFit.scaleDown,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            paddingV: GlobalsSizes(contextAux).marginSpaceSize * 0.25,
            onTap: () async {
              globalsStore.setLoading(true);
              await loginPrincipalFunctions.loginGmail(
                  contextAux, userIds, userInfos);
              globalsStore.setLoading(false);
            },
          ),
          SizedBox(height: GlobalsSizes(contextAux).marginSpaceSize),
          GlobalsButtons(contextAux).buttonPrimaryGlobal(
              text: "Criar Conta",
              colorButton: globalsThemeVar.iGlobalsColors.backgroundItens,
              colorText: globalsThemeVar.iGlobalsColors.primaryColor,
              // colorBorder: globalsThemeVar.iGlobalsColors.primaryColor,
              // isBorder: true,
              paddingV: GlobalsSizes(contextAux).marginSpaceSize * 0.5,
              onTap: () async {
                Navigator.push(
                  contextAux,
                  MaterialPageRoute(builder: (_) => const CreateLoginPage()),
                );
              }),
        ],
      ),
    );
  }

  Widget _loginAdministrador(BuildContext contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalsSizes(context).marginSpaceSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(contextAux, "/login_adm_principal"),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  'Logar como Administrador',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor:
                          globalsThemeVar.iGlobalsColors.primaryColor,
                      color: globalsThemeVar.iGlobalsColors.primaryColor,
                      fontSize: GlobalsSizes(contextAux).sizeTextMedio),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
