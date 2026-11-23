import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'theme_controller.dart';

class GlobalsAlert {
  BuildContext context;
  GlobalsAlert(this.context);

  Future<void> alertWarning(
    contextAux, {
    String title = '',
    String? text,
    String? confirmBtnText,
    VoidCallback? onTap,
    bool showCancelBtn = true,
    String? cancelBtnText,
    VoidCallback? onTapCancel,
  }) async {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(contextAux, listen: false);

    return showDialog(
      context: contextAux,
      builder: (context) {
        return AlertDialog(
          backgroundColor: globalsThemeVar.iGlobalsColors.textColorFraco,
          title: Text(title,
              style: TextStyle(
                  color: globalsThemeVar.iGlobalsColors.primaryColor)),
          content: Text(text ?? '',
              style: TextStyle(
                  color: globalsThemeVar.iGlobalsColors.textColorMedio)),
          actions: [
            if (showCancelBtn)
              TextButton(
                onPressed: onTapCancel ??
                    () {
                      SystemNavigator.pop();
                    },
                child: Text(
                  cancelBtnText ?? "Cancelar",
                  style: TextStyle(
                      color: globalsThemeVar.iGlobalsColors.textColorMedio),
                ),
              ),
            TextButton(
              onPressed: onTap ?? () => Navigator.of(context).pop(),
              child: Text(
                confirmBtnText ?? "Ok",
                style: TextStyle(
                    color: globalsThemeVar.iGlobalsColors.secundaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> alertError(contextAux, {String? text}) async {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(contextAux, listen: false);

    return showDialog(
      context: contextAux,
      builder: (context) {
        return AlertDialog(
          backgroundColor: globalsThemeVar.iGlobalsColors.textColorFraco,
          title: Text('Erro',
              style: TextStyle(
                  color: globalsThemeVar.iGlobalsColors.primaryColor)),
          content: Text(text ?? 'Ocorreu um erro.',
              style: TextStyle(
                  color: globalsThemeVar.iGlobalsColors.textColorMedio)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Ok',
                style: TextStyle(
                    color: globalsThemeVar.iGlobalsColors.secundaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> alertDesejaSair(
    contextAux, {
    String title = '',
    String? text = '',
    VoidCallback? onTap,
  }) async {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(contextAux, listen: false);

    return showDialog(
      context: contextAux,
      builder: (context) {
        return AlertDialog(
          backgroundColor: globalsThemeVar.iGlobalsColors.textColorFraco,
          title: Text(title,
              style: TextStyle(
                  color: globalsThemeVar.iGlobalsColors.primaryColor)),
          content: Text(text ?? '',
              style: TextStyle(
                  color: globalsThemeVar.iGlobalsColors.textColorMedio)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                "Não",
                style: TextStyle(
                    color: globalsThemeVar.iGlobalsColors.textColorFraco),
              ),
            ),
            TextButton(
              onPressed: onTap ?? () async {},
              child: Text(
                "Sim",
                style: TextStyle(
                    color: globalsThemeVar.iGlobalsColors.secundaryColor),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> alertInternet(contextAux) async {
    return showDialog(
      context: contextAux,
      builder: (context) {
        return AlertDialog(
          title: const Text("Ops. Sem Internet"),
          content: const Text("Conecte-se e tente novamente"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
