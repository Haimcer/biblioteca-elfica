import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:provider/provider.dart';

class GlobalsStyles {
  late BuildContext context;
  final GlobalsThemeVar globalsThemeVar;
  late TextStyle styleTitle;
  late TextStyle styleSubtitle;
  late TextStyle styleMedio;
  late TextStyle styleMenor;
  late dynamic negritoFont;

  GlobalsStyles(this.context)
      : globalsThemeVar = Provider.of<GlobalsThemeVar>(context, listen: false) {
    styleTitle = TextStyle(
        color: globalsThemeVar.iGlobalsColors.primaryColor,
        fontSize: GlobalsSizes(context).sizeTitulo);
    styleSubtitle = TextStyle(
        fontWeight: FontWeight.w500,
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes(context).sizeSubtitulo);
    styleMedio = TextStyle(
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes(context).sizeTextMedio);
    styleMenor = TextStyle(
        color: globalsThemeVar.iGlobalsColors.textColorForte,
        fontSize: GlobalsSizes(context).sizeText);
    negritoFont = FontWeight.w500;
  }
}
