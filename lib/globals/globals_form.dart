import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'globals_vars.dart';
import 'theme_controller.dart';

class GlobalsForm {
  BuildContext context;
  GlobalsForm(this.context);

  Widget campoTextFieldTexto(TextEditingController controller, hintText,
      {Widget? suffixIcon,
      int? maxLines,
      bool isData = false,
      validator,
      void Function()? functionSuffix,
      Function(String)? onChanged,
      TextInputType? textInputType,
      double? height,
      double? width,
      int? maxLength,
      bool obscureText = false,
      // bool isBorderBottom = false,
      Color? hintTextColor,
      Color? colorBackGround,
      bool isTextAlignCenter = true,
      List<TextInputFormatter>? inputFormatters}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return Container(
      height: height ?? 60,
      width: width,
      padding: EdgeInsets.symmetric(
          horizontal: GlobalsSizes(context).marginSpaceSize),
      //margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: boxDecorationTextField(backgroundColor: colorBackGround),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            maxLines: maxLines ?? 1,
            maxLength: maxLength,
            keyboardType: textInputType,
            obscureText: obscureText,
            validator: validator,
            textAlign: isTextAlignCenter ? TextAlign.center : TextAlign.start,
            inputFormatters: inputFormatters ??
                (isData ? [DateMaskTextInputFormatter()] : null),
            style: TextStyle(
                color: globalsThemeVar.iGlobalsColors.textColorForte,
                fontSize: GlobalsSizes(context).sizeTextMedio,
                fontWeight: FontWeight.normal),
            decoration: InputDecoration(
              hintText: '$hintText',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: globalsThemeVar.iGlobalsColors
                      .secundaryColor, // Cor da borda inferior quando não focado
                  width: 2.0,
                ),
              ),
              suffixIcon: suffixIcon == null ? null : suffixIcon,
              suffixIconColor: suffixIcon == null
                  ? null
                  : globalsThemeVar.iGlobalsColors.secundaryColor,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: globalsThemeVar.iGlobalsColors
                      .primaryColor, // Cor da borda inferior quando focado
                  width: 2.0,
                ),
              ),
              hintStyle: TextStyle(
                  color: hintTextColor ??
                      globalsThemeVar.iGlobalsColors.textColorFraco,
                  fontWeight: FontWeight.normal),
            ),
            onChanged: onChanged,
            controller: controller,
          ),
        ],
      ),
    );
  }

  Widget campoTextData(
    TextEditingController controller,
    String? nomeCampo,
    String? Function(String?)? validator, {
    TextInputType? textInputType,
    Color? colorBackground,
    Function(String)? onChanged,
    bool isSombreado = true,
    bool? isDense,
    Color? corBorda,
    bool enabled = true,
  }) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GlobalsSizes(context).marginSpaceSize,
      ),
      height: 60,
      decoration: boxDecorationTextField(backgroundColor: colorBackground),
      child: TextFormField(
        keyboardType: textInputType ?? TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Permite apenas números
          DataInputFormatter(), // Formata como dd/MM/yyyy
        ],
        enabled: enabled,
        style: TextStyle(
          color: globalsThemeVar.iGlobalsColors.textColorForte,
          fontSize: GlobalsSizes(context).sizeTextMedio,
          fontWeight: FontWeight.normal,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: globalsThemeVar.iGlobalsColors.secundaryColor,
              width: 2.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: globalsThemeVar.iGlobalsColors.primaryColor,
              width: 2.0,
            ),
          ),
          hintText: nomeCampo ?? "dd/MM/yyyy",
          hintStyle: TextStyle(
            color: globalsThemeVar.iGlobalsColors.textColorFraco,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget campoTextNum(
    controller,
    String? nomeCampo,
    validator,
    List<TextInputFormatter>? inputFormatters, {
    TextInputType? textInputType,
    Color? colorBackground,
    Function(String)? onChanged,
    bool isSombreado = true,
    // double? borderSize,
    bool? isDense,
    Color? corBorda,
    bool enabled = true,
    // bool isBorderBottom = false
  }) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: GlobalsSizes(context).marginSpaceSize),
      height: 60,
      decoration: boxDecorationTextField(backgroundColor: colorBackground),
      child: TextFormField(
        keyboardType: textInputType ?? TextInputType.text,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: controller,
        validator: validator,
        onChanged: onChanged,
        textAlign: TextAlign.center,
        inputFormatters: inputFormatters ?? [],
        enabled: enabled,
        style: TextStyle(
            color: globalsThemeVar.iGlobalsColors.textColorForte,
            fontSize: GlobalsSizes(context).sizeTextMedio,
            fontWeight: FontWeight.normal),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: globalsThemeVar.iGlobalsColors
                  .secundaryColor, // Cor da borda inferior quando não focado
              width: 2.0,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: globalsThemeVar.iGlobalsColors
                  .primaryColor, // Cor da borda inferior quando focado
              width: 2.0,
            ),
          ),
          // border: isBorderBottom ? null : InputBorder.none,
          hintText: nomeCampo,
          hintStyle: TextStyle(
              color: globalsThemeVar.iGlobalsColors.textColorFraco,
              // fontSize: GlobalsSizes(context).sizeText,
              fontWeight: FontWeight.normal),
          // isDense: isDense ?? false,
          // contentPadding: EdgeInsets.symmetric(
          //     horizontal: GlobalsSizes(context).marginSpaceSize / 2,
          //     vertical: isDense ?? false ? GlobalsSizes(context).marginSpaceSize/2 : 0),
        ),
        // textAlignVertical: TextAlignVertical.top,
      ),
    );
  }

  BoxDecoration boxDecorationTextField(
      {Color? corBorda, Color? backgroundColor}) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return BoxDecoration(
      color: backgroundColor ?? globalsThemeVar.iGlobalsColors.backgroundItens,
      borderRadius:
          BorderRadius.all(Radius.circular(GlobalsSizes(context).borderSize)),

      // border: Border.all(
      //     color: globalsThemeVar.iGlobalsColors.primaryColor,
      //     style: BorderStyle.solid,
      //     width: corBorda == null ? 0 : 1),
    );
  }

  // DROPDOWN COMPONENTIZADO #############
  Widget dropDownOpcoesForm(BuildContext contextAux,
      {required String? valueSelect,
      required List<DropdownMenuItem<String>>? itemsDropDown,
      required String hintText,
      required void Function(String?)? onChanged,
      bool isBorder = true}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    // final cadastraVeiculosStore =
    //     Provider.of<CadastraVeiculosStore>(context);
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: GlobalsSizes().marginSize),
      decoration: BoxDecoration(
        color: globalsThemeVar.iGlobalsColors.backgroundItens,
        borderRadius: BorderRadius.all(
            Radius.circular(GlobalsSizes(contextAux).borderSize)),
        // border: Border.,
      ),
      // height: 50,
      padding: EdgeInsets.symmetric(
          horizontal: GlobalsSizes(contextAux).marginSpaceSize / 2,
          vertical: GlobalsSizes(contextAux).marginSpaceSize / 4),
      width: MediaQuery.of(context).size.width,
      child: DropdownButtonFormField(
        iconSize: 30,
        decoration: InputDecoration(
          enabled: true,
          // disabledBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(
          //     color: Colors.red,
          //     width: 2,
          //     style: BorderStyle.solid,
          //   ),
          // ),
          enabledBorder: !isBorder
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                      // Cor da borda inferior quando não focado
                      color: Colors.transparent),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: globalsThemeVar.iGlobalsColors
                        .secundaryColor, // Cor da borda inferior quando não focado
                    width: 2.0,
                  ),
                ),
          focusedBorder: !isBorder
              ? UnderlineInputBorder(
                  borderSide: BorderSide(
                      // Cor da borda inferior quando não focado
                      color: Colors.transparent),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: globalsThemeVar.iGlobalsColors
                        .primaryColor, // Cor da borda inferior quando focado
                    width: 2.0,
                  ),
                ),
        ),
        alignment: Alignment.center,
        icon: Icon(
          Icons.keyboard_arrow_down,
          color: globalsThemeVar.iGlobalsColors.textColorMedio,
        ),
        isExpanded: true,
        dropdownColor: globalsThemeVar.iGlobalsColors.backgroundItens,
        //style: KThemeModeApp.of(context).bodyLarge,
        value: valueSelect,
        items: itemsDropDown,
        hint: Text(
          hintText,
          style: TextStyle(
              color: globalsThemeVar.iGlobalsColors.textColorFraco,
              fontSize: GlobalsSizes(context).sizeTextMedio),
        ),
        onChanged: onChanged,
      ),
    );
  }

  Widget dadosListOpcoesSelect(BuildContext contextAux,
      {String? nomeTitle,
      String? nomeEspecificacaoVeiculo,
      Widget? prefixWid}) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: GlobalsSizes(contextAux).marginSpaceSize / 2),
            decoration: BoxDecoration(
              color: globalsThemeVar.iGlobalsColors.backgroundItens,
              borderRadius: BorderRadius.all(
                  Radius.circular(GlobalsSizes(contextAux).borderSize)),
            ),
            // height: 50,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(
                      GlobalsSizes(contextAux).marginSpaceSize / 2),
                  // child: nomeEspecificacaoVeiculo == null ?
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                              child: Text(
                            nomeTitle ?? 'tipo não informado',
                            style: TextStyle(
                                color: globalsThemeVar
                                    .iGlobalsColors.textColorMedio,
                                fontSize:
                                    GlobalsSizes(contextAux).sizeTextMedio,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ))
                        ],
                      ),
                      nomeEspecificacaoVeiculo == null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                    child: Text(
                                  nomeEspecificacaoVeiculo,
                                  style: TextStyle(
                                    color: globalsThemeVar
                                        .iGlobalsColors.textColorForte,
                                    fontSize:
                                        GlobalsSizes(contextAux).sizeTextMedio,
                                    // fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.center,
                                ))
                              ],
                            ),
                    ],
                  ),
                  //:
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: GlobalsSizes(contextAux).marginSpaceSize / 2),
                  color: globalsThemeVar.iGlobalsColors
                      .secundaryColor, // Cor da borda inferior quando não focado
                  height: 2.0,
                  width: MediaQuery.of(context).size.width,
                ),
              ],
            ),
          ),
        ),
        prefixWid ?? Container(),
      ],
    );
  }
}

// Classe para definir a máscara de data
class DateMaskTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    // Remove caracteres que não são números
    text = text.replaceAll(RegExp(r'[^0-9]'), '');

    // Adiciona a máscara DD/MM/YYYY
    var newText = '';
    for (var i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        newText += '/';
      }
      if (i < 8) {
        newText += text[i];
      }
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

/// **Classe que formata a entrada do usuário para o formato dd/MM/yyyy**
class DataInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text =
        newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove não números

    String formatted = '';
    for (int i = 0; i < text.length; i++) {
      if (i == 2 || i == 4) {
        formatted += '/';
      }
      formatted += text[i];
    }

    if (formatted.length > 10) {
      formatted = formatted.substring(
          0, 10); // Garante que o tamanho máximo seja dd/MM/yyyy
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
