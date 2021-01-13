import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:weight_tracker/src/DataLayer/repository/auth_repo.dart';
import 'package:weight_tracker/src/bloC/baseBloC.dart';
import 'package:weight_tracker/src/models/user.dart';
import 'package:weight_tracker/src/validators/validators.dart';

class LoginBloC extends Object with Validators implements BaseBloC {
  final _usernameController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  AuthRepository _authRepository = AuthRepository();

  Function(String) get usernameChanged => _usernameController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  Stream<String> get username =>
      _usernameController.stream.transform(usernameValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  loginUser(User user) async {
    return await _authRepository.loginUser(user);
  }

  int decodeToken(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token.trim());
    print(decodedToken);
    return decodedToken["id"];
  }

  Stream<bool> get loginCheck =>
      Rx.combineLatest2(username, password, (n, p) => true);

  storeToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print('LOGIN token login' + token);
  }

  @override
  void dispose() {
    _usernameController?.close();
    _passwordController?.close();
  }
}
