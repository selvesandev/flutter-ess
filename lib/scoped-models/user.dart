import 'dart:convert';

import 'package:flutteress/models/auth.dart';
import 'package:flutteress/models/user.dart';
import 'package:flutteress/scoped-models/connected_scopes.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserModal extends ConnectedScopes {
  User get user {
    return c_authenticatedUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      [AuthMode mode = AuthMode.Login]) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    String requestUrl =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyD6te-l2B916ku0qijYtnK-HvikQUFe8tk';
    if (mode == AuthMode.Signup) {
      requestUrl =
          'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyD6te-l2B916ku0qijYtnK-HvikQUFe8tk';
    }

    c_isLoading = true;
    notifyListeners();
    final http.Response response = await http.post(requestUrl,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'});

    final Map<String, dynamic> responseData = json.decode(response.body);
    bool hasError = true;
    String message = "Something went wrong";
    if (responseData.containsKey('idToken')) {
      hasError = false;
      message = 'Success';
      c_authenticatedUser = User(
          id: responseData['localId'],
          email: email,
          token: responseData['idToken']);
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('_auth_token', responseData['idToken']);
      await prefs.setString('email', responseData['email']);
      await prefs.setString('userId', responseData['localId']);
    } else if (responseData['error']['message'] == 'EMAIL_NOT_FOUND') {
      message = 'Email was not found';
    } else if (responseData['error']['message'] == 'INVALID_PASSWORD') {
      message = 'Invalid password';
    } else if (responseData['error']['message'] == 'EMAIL_EXISTS') {
      message = 'This email is already registered';
    }
    c_isLoading = false;
    notifyListeners();

    return {'success': !hasError, 'message': message};
  }

  void authenticatedCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('_auth_token');
    if (token != null) {
      c_authenticatedUser = User(
          id: prefs.getString('userId'),
          email: prefs.getString('email'),
          token: prefs.getString('_auth_token'));
    }
  }

  void logout() async {
    c_authenticatedUser = null;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('_auth_token');
    prefs.remove('email');
    prefs.remove('userId');
    notifyListeners();
  }
}
