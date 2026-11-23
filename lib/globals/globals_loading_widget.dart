import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart' show GlobalsThemeVar;
import 'package:provider/provider.dart';

class GlobalsLoadingWidget {
  BuildContext context;
  GlobalsLoadingWidget(this.context);

  Widget loadingPrincipal({Color? backgroundColor, Color? color}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? globalsThemeVar.iGlobalsColors.primaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: color ?? globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
                /*rightDotColor: rightDotColor ??
                      globalsThemeVar.iGlobalsColors.tertiaryColor,*/
                //strokeWidth: 40
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loagingPageInicio(double sizeHeight, double sizeWidth,
      {String? text}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      height: sizeHeight,
      width: sizeWidth,
      padding: EdgeInsets.all(GlobalsSizes(context).marginSpaceSize*2),
      color: globalsThemeVar.iGlobalsColors.backgroundColor,
      // decoration: BoxDecoration(
      //     gradient: globalsThemeVar.iGlobalsColors.colorGradiente),
      // padding: EdgeInsets.symmetric(
      //     vertical: MediaQuery.of(context).size.height / 4),
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo_principal.png',),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Desenvolvido por:',
                style: TextStyle(
                  color:
                      globalsThemeVar.iGlobalsColors.textColorForte,
                  fontSize: GlobalsSizes(context).sizeTextMedio,
                  fontWeight: FontWeight.bold,
                  
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
                Expanded(child: Container(),),
                Expanded(
                  flex: 2,
                  child: Image.asset('assets/images/smart_publica.png',)),
                Expanded(child: Container(),),
            ],
          ),
        ],
      ),
    );
  }
}
