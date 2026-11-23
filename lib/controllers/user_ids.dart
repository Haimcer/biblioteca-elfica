import 'package:firebase_auth/firebase_auth.dart';

class UserIds {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var idToken;
  var uidUser;
  var tokenAPI;

  void setIds(idTokenAux, uidUserAux) {
    tokenAPI = idTokenAux;
    uidUser = uidUserAux;
  }

  void setTokenAPI(tokenAPIAux) => tokenAPI = tokenAPIAux;

  Future<String?> setRenovaToken() async {
    print("token antigo $idToken");
    final idTokenAux = await _auth.currentUser?.getIdToken();
    print("token nove $idTokenAux");

    this.idToken = idTokenAux;
    return idTokenAux;
  }
}
