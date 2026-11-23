import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:intl/intl.dart';

class GlobalsFunctions {
  ///Verifica conexão com a internet
  Future<bool> verificaConexao() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return true;
    } else {
      return false;
    }
  }

  bool validaEmail(String value) {
    bool emailValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
    print("emailValid: $emailValid");
    return emailValid;
  }

  String formataDataComentario(DateTime? data) {
  if (data == null) return '';
  final DateFormat formatter = DateFormat("d 'de' MMMM 'de' y 'às' HH:mm", 'pt_BR');
  return formatter.format(data);
}

}
