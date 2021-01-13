import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:weight_tracker/src/DataLayer/repository/auth_repo.dart';
import 'package:weight_tracker/src/bloC/baseBloC.dart';
import 'package:weight_tracker/src/models/user.dart';
import 'package:weight_tracker/src/validators/validators.dart';

class SignUpBloC extends Object with Validators implements BaseBloC {
  final _usernameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _confirmPwdController = BehaviorSubject<String>();
  AuthRepository _authRepository = AuthRepository();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get usernameChanged => _usernameController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;
  Function(String) get confirmpwdChanged => _confirmPwdController.sink.add;

  Stream<String> get username =>
      _usernameController.stream.transform(usernameValidator);
  Stream<String> get password =>
      _passwordController.stream.transform(passwordValidator);

  Stream<String> get comfirmPassword => _confirmPwdController.stream
          .transform(passwordValidator)
          .doOnData((String cp) {
        if (0 != _passwordController.value.compareTo(cp))
          _confirmPwdController.addError('Passwords do not match');
      });

  Stream<bool> get registerCheck => Rx.combineLatest3(
      username, password, comfirmPassword, (n, p, cp) => true);

  registerUser(User user) async {
    return await _authRepository.registerUser(user);
  }

  @override
  void dispose() {
    _usernameController?.close();
    _emailController?.close();
    _passwordController?.close();
    _confirmPwdController?.close();
  }
}
