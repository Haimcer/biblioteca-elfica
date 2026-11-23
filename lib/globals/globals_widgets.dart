import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_styles.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'theme_controller.dart';

class GlobalsWidgets {
  GlobalsWidgets(this.context);
  BuildContext context;
  

    Widget dividerGlobal() {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return 
        Divider(color: globalsThemeVar.iGlobalsColors.backgroundItens,);
  }

  Widget voltarTextIcon(BuildContext contextAux, {VoidCallback? onTap, String? text, IconData? icon}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return GestureDetector(
      onTap: onTap ?? () => Navigator.pop(contextAux),
      child: 
      // Container(
      //   color: Colors.red,
      //   child: 
        Row(
          children: [
            Icon(icon ?? Icons.arrow_left_rounded,
            color: globalsThemeVar.iGlobalsColors.primaryColor,
            size: GlobalsSizes(contextAux).sizeTitulo*(icon != null ? 1.3 : 2),
            ),
            Text(text ?? 'Voltar',
              style: TextStyle(
                color: globalsThemeVar.iGlobalsColors.textColorMedio,
                fontSize: GlobalsSizes(contextAux).sizeTextMedio,
                decoration: TextDecoration.underline
              ),
            ),
          ],
        ),
      // ),
    );
  }

  BoxShadow sombreadoBoxShadow() {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return BoxShadow(
      color: globalsThemeVar.iGlobalsColors.sombreado,
      blurRadius: 15.0,
      spreadRadius: 0.2,
      offset: const Offset(
        2.0,
        3.0,
      ),
    );
  }

  Widget imgEmpty({double? sizew, String? text, Widget? richtext}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          width: sizew ?? MediaQuery.of(context).size.height / 2.5,
          child: Image.asset('assets/img_error.png'),
        ),
        Container(
          margin: EdgeInsets.all(GlobalsSizes(context).marginSpaceSize),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: richtext ??
                      Text(
                        text ?? 'Ops! Nada por aqui',
                        style: TextStyle(
                            color:
                                globalsThemeVar.iGlobalsColors.textColorMedio,
                            fontSize: GlobalsSizes(context).sizeTextMedio),
                        textAlign: TextAlign.center,
                      )),
            ],
          ),
        ),
        const SizedBox(
          height: 40,
        ),
      ],
    );
  }

  Widget loading({double? size}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Center(
      child: LoadingAnimationWidget.twistingDots(
        leftDotColor: globalsThemeVar.iGlobalsColors.primaryColor,
        rightDotColor: globalsThemeVar.iGlobalsColors.secundaryColor,
        size: size ?? 70,
      ),
    );
  }

  Widget appBarDescTitulo(BuildContext contextAux,
      {double? sizeH,
      double? sizeW,
      Widget? prefixWidget,
      Widget? sufixWidget,
      String? titulo,
      String? descTitulo,
      double? marginBottomTitle,
      String? urlImg}) {
    // final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final sizeMediaQ = MediaQuery.of(contextAux).size;
    return SizedBox(
      height: sizeH ?? sizeMediaQ.width / 2.5,
      width: sizeW ?? sizeMediaQ.width,
      child: Stack(
        children: [
          Container(
            height: sizeH ?? sizeMediaQ.width / 2.5,
            width: sizeW ?? sizeMediaQ.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(GlobalsSizes(contextAux).borderSize * 2.5)),
              image: urlImg == null || urlImg == 'null'
                  ? const DecorationImage(
                      image: AssetImage("assets/img_capa.jpg"),
                      fit: BoxFit.cover,
                    )
                  : DecorationImage(
                      image: NetworkImage(urlImg),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          Container(
            height: sizeH ?? sizeMediaQ.width / 2.5,
            width: sizeW ?? sizeMediaQ.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(GlobalsSizes(contextAux).borderSize * 2.5)),
                color: Colors.black54),
          ),
          Container(
            margin: EdgeInsets.all(GlobalsSizes(contextAux).marginSpaceSize),
            child: Column(
              children: [
                prefixWidget == null && sufixWidget == null
                    ? Container()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          prefixWidget ?? Container(),
                          sufixWidget ?? Container(),
                        ],
                      ),
                Expanded(
                  child: titulo == null
                      ? Container()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              descTitulo ?? '',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: GlobalsSizes(contextAux).sizeTextMedio,
                                //fontWeight: GlobalsStyles().negritoFont,
                              ),
                            ),
                            Text(
                              titulo,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: GlobalsSizes(contextAux).sizeSubtitulo,
                                fontWeight: GlobalsStyles(context).negritoFont,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                ),
                SizedBox(
                  height: marginBottomTitle ?? 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
