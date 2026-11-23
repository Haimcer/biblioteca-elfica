// Função para obter o número de linhas baseado na largura da tela
import 'package:flutter/material.dart';

int getNumeroDeLinhas(BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;

  if (screenWidth < 600) {
    // Para dispositivos móveis (tela pequena)
    return 2; // Exemplo: 2 linhas para dispositivos móveis
  } else if (screenWidth >= 600 && screenWidth < 800) {
    // Para telas de tablet ou dispositivos médios
    return 3; // 3 linhas para tablets
  } else if (screenWidth >= 800 && screenWidth < 1024) {
    // Para telas maiores (ex: tablets grandes)
    return 4; // 4 linhas para telas grandes
  } else if (screenWidth >= 1024 && screenWidth < 1440) {
    // Para telas de computador menores
    return 6; // 6 linhas para computadores menores
  } else if (screenWidth >= 1440 && screenWidth < 1920) {
    // Para telas grandes (ex: desktops de 1080p)
    return 8; // 8 linhas para telas maiores
  } else {
    // Para telas muito grandes (ex: desktops 4k)
    return 10; // 10 linhas para telas 4k ou maiores
  }
}

bool isProd = false;

class GlobalsVars {
  final urlAPI = const String.fromEnvironment('API_URL', defaultValue: 'http://localhost:3000');

  String nomeApp = "Elarith - The elven library";
}

class GlobalsSizesScreen {
  final double smallScreenMax = 767; //540; //tela pequena tam maximo
  final double mediumScreenMax = 1199; //800; //tela media tam maximo
  // a partir de mediumScreenMax é tela grande (large)
}

class GlobalsStylesFont {
  var negritoFont = FontWeight.bold;
  final String fontTitle = "TTNormsPro";
  final String fontName = "TTNormsPro"; //"ScriptMTBold";
}


class GlobalsSizes {
  BuildContext contextAux;
  GlobalsSizes(this.contextAux);

  final double borderSize = 15;
  final double marginPageSize = 120;
  final double marginSpaceSize = 25;

  // Espaco que fica no fundo da appBar
  get sizedBoxAppBar {
    double sizeWidth = MediaQuery.of(contextAux).size.width;
    if (sizeWidth < GlobalsSizesScreen().smallScreenMax) {
      return GlobalsSizes(contextAux).sizeTitulo + (GlobalsSizes(contextAux).marginSpaceSize*2);
    }
    if (sizeWidth < GlobalsSizesScreen().mediumScreenMax) {
      return 100.00;
    }
    return 100.00;
  }

  get sizeMegaTitulo {
    double sizeWidth = MediaQuery.of(contextAux).size.width;
    if (sizeWidth < GlobalsSizesScreen().smallScreenMax) {
      return GlobalsSizesMobile().sizeMegaTitulo;
    }
    if (sizeWidth < GlobalsSizesScreen().mediumScreenMax) {
      return GlobalsSizesMobile().sizeMegaTitulo;
    }
    return GlobalsSizesWeb().sizeMegaTitulo;
  }

  get sizeTitulo {
    double sizeWidth = MediaQuery.of(contextAux).size.width;
    if (sizeWidth < GlobalsSizesScreen().smallScreenMax) {
      return GlobalsSizesMobile().sizeTitulo;
    }
    if (sizeWidth < GlobalsSizesScreen().mediumScreenMax) {
      return GlobalsSizesMobile().sizeTitulo;
    }
    return GlobalsSizesWeb().sizeTitulo;
  }
  
  get sizeSubtitulo {
    double sizeWidth = MediaQuery.of(contextAux).size.width;
    if (sizeWidth < GlobalsSizesScreen().smallScreenMax) {
      return GlobalsSizesMobile().sizeSubtitulo;
    }
    if (sizeWidth < GlobalsSizesScreen().mediumScreenMax) {
      return GlobalsSizesMobile().sizeSubtitulo;
    }
    return GlobalsSizesWeb().sizeSubtitulo;
  }
  
  get sizeTextMedio {
    double sizeWidth = MediaQuery.of(contextAux).size.width;
    if (sizeWidth < GlobalsSizesScreen().smallScreenMax) {
      return GlobalsSizesMobile().sizeTextMedio;
    }
    if (sizeWidth < GlobalsSizesScreen().mediumScreenMax) {
      return GlobalsSizesMobile().sizeTextMedio;
    }
    return GlobalsSizesWeb().sizeTextMedio;
  }
  
  get sizeText {
    double sizeWidth = MediaQuery.of(contextAux).size.width;
    if (sizeWidth < GlobalsSizesScreen().smallScreenMax) {
      return GlobalsSizesMobile().sizeText;
    }
    if (sizeWidth < GlobalsSizesScreen().mediumScreenMax) {
      return GlobalsSizesMobile().sizeText;
    }
    return GlobalsSizesWeb().sizeText;
  }
  
}

class GlobalsSizesWeb {
  final sizeMegaTitulo = 60.00;
  final sizeTitulo = 40.00; //24.0;
  final sizeSubtitulo = 24.00; //20.0;
  final sizeTextMedio = 18.00; //18.0;
  final sizeText = 13.00; //13.0;
}

class GlobalsSizesMobile {
  //Mobile
  final sizeMegaTitulo = 35.00;
  final sizeTitulo = 19.00; //24.0;
  final sizeSubtitulo = 15.00; //20.0;
  final sizeTextMedio = 11.00; //18.0;
  final sizeText = 6.00;
}
