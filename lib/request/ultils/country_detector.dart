import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;

/// Mapa para padronizar o nome da região que o seu back‑end usa
const _codeToRegion = <String, String>{
  'BR': 'Brasil',
  'US': 'EUA',
  'ES': 'Espanha',
  'DE': 'Alemanha',
  'JP': 'Japão',
};

/// Tenta obter o código de país em 3 passos:
/// 1. Locale do sistema   (Web ou Mobile)
/// 2. Locale secundário   (`PlatformDispatcher`) – útil no Web também
/// 3. Consulta de IP (ipapi.co) — sem precisar de permissão
Future<String> detectarCodigoPais() async {
  // 1) locale primário
  String? code;
  if (kIsWeb) {
    // ex.: "pt-BR", "en-US"
    final lang = (ui.PlatformDispatcher.instance.locales.isNotEmpty
            ? ui.PlatformDispatcher.instance.locales.first
            : null)
        ?.toLanguageTag(); // tenta pegar pela API nova
    code = lang?.split('-').last;
  } else {
    code = ui.PlatformDispatcher.instance.locale.countryCode;
  }
  code = code?.toUpperCase() ?? '';

  // 2) fallback: verifica se há outros locales
  if (code.isEmpty || code.length != 2) {
    final fallback = ui.PlatformDispatcher.instance.locales.isNotEmpty
        ? ui.PlatformDispatcher.instance.locales.first.countryCode
        : null;
    code = fallback?.toUpperCase() ?? '';
  }

  // 3) fallback via IP se ainda não achou
  if (code.isEmpty) {
    try {
      final res = await http.get(Uri.parse('https://ipapi.co/json/'))
          .timeout(const Duration(seconds: 3));
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        code = (data['country_code'] as String?)?.toUpperCase() ?? '';
      }
    } catch (_) {
      // ignore – continua vazio
    }
  }

  // Se tudo falhar, usa "US" como padrão
  if (code!.isEmpty || code.length != 2) code = 'US';

  return code; // "BR", "US", ...
}

/// Converte para sua string padronizada ("Brasil", "EUA", ...)
Future<String> detectarRegiaoPadrao() async {
  final code = await detectarCodigoPais();
  return _codeToRegion[code] ?? code;
}
