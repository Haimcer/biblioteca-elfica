import 'package:intl/intl.dart';

String formatarMoeda(num valor, String codigo) {
  try {
    return valor == 0
        ? 'Grátis'
        : NumberFormat.simpleCurrency(name: codigo).format(valor);
  } catch (_) {
    return valor.toStringAsFixed(2);
  }
}
