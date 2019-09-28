import 'package:flutteress/models/user.dart';
import 'package:flutteress/scoped-models/connected_scopes.dart';

class UserModal extends ConnectedScopes {
  void login(String email, String password) {
    c_authenticatedUser =
        User(id: 'selvesan', email: email, password: password);
        
  }
}
