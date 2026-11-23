import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:provider/provider.dart';
import 'globals_widgets.dart';

class GlobalsButtons {
  BuildContext context;
  GlobalsButtons(this.context);

  // BOTAO GLOBAL

  Widget buttonPrimaryGlobal(
      {required String text,
      Color? colorText,
      double? sizeText,
      Gradient? gradientColor,
      Color? colorButton,
      bool isSombreado = true,
      double? widthBtn,
      double? paddingH,
      double? paddingV,
      bool isBorder = false,
      Color? colorBorder,
      Widget? prefixWid,
      IconData? iconSuf,
      VoidCallback? onTap,
      bool isNegritoText = false}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: widthBtn,
          padding: EdgeInsets.symmetric(
              horizontal: paddingH ?? 0, vertical: paddingV ?? 8),
          decoration: BoxDecoration(
            gradient: gradientColor,
            color: colorButton,
            // boxShadow: !isSombreado
            //     ? null
            //     : [GlobalsWidgets(context).sombreadoBoxShadow()],
            borderRadius: BorderRadius.all(
                Radius.circular(GlobalsSizes(context).borderSize / 2)),
            border: !isBorder
                ? null
                : Border.all(
                    color: colorBorder ??
                        globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
                    width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              prefixWid ?? Container(),
              prefixWid != null ? const SizedBox(width: 7) : Container(),
              widthBtn != null
                  ? Flexible(
                      child: Text(
                        text,
                        style: TextStyle(
                            color: colorText ??
                                globalsThemeVar
                                    .iGlobalsColors.textColorPrimaryInverse,
                            fontSize:
                                sizeText ?? GlobalsSizes(context).sizeTextMedio,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: isNegritoText ? FontWeight.bold : null),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Flexible(
                      child: Text(
                        text,
                        style: TextStyle(
                            color: colorText ??
                                globalsThemeVar
                                    .iGlobalsColors.textColorPrimaryInverse,
                            fontSize:
                                sizeText ?? GlobalsSizes(context).sizeTextMedio,
                            fontWeight: isNegritoText ? FontWeight.bold : null),
                        textAlign: TextAlign.center,
                      ),
                    ),
              iconSuf != null ? const SizedBox(width: 7) : Container(),
              iconSuf != null
                  ? Icon(
                      iconSuf,
                      size: GlobalsSizes(context).sizeTextMedio,
                      color: colorText ??
                          globalsThemeVar
                              .iGlobalsColors.textColorPrimaryInverse,
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  //
  Widget buttonPrimary(corBtn, corText, String text, VoidCallback? onTap,
      {double? paddingHoriz,
      double? paddingVert,
      double? marginHoriz,
      IconData? iconSuf,
      Widget? prefix,
      Color? corBorda,
      bool isSombreado = true}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
              horizontal: paddingHoriz ?? 7, vertical: paddingVert ?? 7),
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
              horizontal: marginHoriz ?? GlobalsSizes(context).marginSpaceSize),
          decoration: BoxDecoration(
              boxShadow: [
                isSombreado
                    ? GlobalsWidgets(context).sombreadoBoxShadow()
                    : BoxShadow(),
              ],
              color: corBtn,
              borderRadius: BorderRadius.all(
                  Radius.circular(GlobalsSizes(context).borderSize)),
              border: Border.all(
                  color: corBorda ?? Colors.transparent,
                  style: BorderStyle.solid,
                  width: corBorda == null ? 0 : 1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              prefix ?? Container(),
              prefix != null ? const SizedBox(width: 7) : Container(),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(
                    color: corText,
                    fontSize: GlobalsSizes(context).sizeSubtitulo,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              iconSuf != null ? const SizedBox(width: 7) : Container(),
              iconSuf != null
                  ? Icon(iconSuf,
                      size: GlobalsSizes(context).sizeSubtitulo, color: corText)
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
