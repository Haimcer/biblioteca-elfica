import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leitor_ebooks/controllers/user_ids.dart';
import 'package:leitor_ebooks/controllers/user_infos.dart';
import 'package:leitor_ebooks/globals/globals_buttons.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/globals/store/globals_store.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals_form.dart';
import 'create_login_functions.dart';
import 'store/create_login_store.dart';

class CreateLoginWidget {
  BuildContext context;
  CreateLoginWidget(this.context);

  Widget createLoginWidgetPrincipal(BuildContext contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return ListView(
      children: [
        SizedBox(height: (GlobalsSizes(context).marginSpaceSize * 2)),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: GlobalsSizes(context).marginSpaceSize),
          child: GlobalsWidgets(context).voltarTextIcon(context, onTap: () {
            Navigator.pop(context);
          }),
        ),
        SizedBox(height: (GlobalsSizes(context).marginSpaceSize)),
        
              Container(
                padding: EdgeInsets.symmetric(
              horizontal: GlobalsSizes(contextAux).marginSpaceSize, vertical: GlobalsSizes(contextAux).marginSpaceSize),
                child: Row(
                  children: [
                    Flexible(child: Text('Cadastre-se para Começar a usar os Nossos Serviços',
                      style: TextStyle(
                        color: globalsThemeVar.iGlobalsColors.textColorMedio,
                        fontSize: GlobalsSizes(contextAux).sizeTitulo,
                        fontWeight: FontWeight.bold
                      ),
                    ),),
                  ],
                ),
              ),
        SizedBox(height: (GlobalsSizes(context).marginSpaceSize)),
        _formCreate(contextAux),
        SizedBox(height: (GlobalsSizes(context).marginSpaceSize)),
      ],
    );
  }

  Widget _formCreate(BuildContext contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final createLoginFunctions =
        Provider.of<CreateLoginFunctions>(context);
    final createLoginStoreT = Provider.of<CreateLoginStore>(context);
    final createLoginStoreF =
        Provider.of<CreateLoginStore>(context, listen: false);
    final userInfos = Provider.of<UserInfos>(context);
    final userIds = Provider.of<UserIds>(context);
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
              createLoginFunctions.controllerEmail, "Digite seu email"),
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
              createLoginFunctions.controllerSenha,
              "Digite sua senha",
              obscureText: createLoginStoreT.obscureTextSenha,
              suffixIcon: IconButton(
                  onPressed: () => createLoginStoreF.setObscureTextSenha(),
                  icon: Icon(
                    createLoginStoreT.obscureTextSenha
                        ? FontAwesomeIcons.eye
                        : FontAwesomeIcons.eyeLowVision,
                    size: GlobalsSizes(context).sizeTextMedio,
                    color: globalsThemeVar.iGlobalsColors.textColorMedio,
                  )),
            );
          }),
          SizedBox(
            height: GlobalsSizes(contextAux).marginSpaceSize
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Confirmar Senha",
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
              createLoginFunctions.controllerConfSenha,
              "Digite sua senha",
              obscureText: createLoginStoreT.obscureTextConfSenha,
              suffixIcon: IconButton(
                  onPressed: () => createLoginStoreF.setObscureTextConfSenha(),
                  icon: Icon(
                    createLoginStoreT.obscureTextConfSenha
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
              await createLoginFunctions.loginCreateAccount(
                  contextAux, userIds, userInfos);
              globalsStore.setLoading(false);
              }
              ),
          SizedBox(
            height: GlobalsSizes(contextAux).marginSpaceSize * 2,
          ),
        ],
      ),
    );
  }
}
