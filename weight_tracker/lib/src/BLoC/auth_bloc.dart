import 'dart:async';

import 'package:weight_tracker/src/BloC/baseBloC.dart';

class AuthBloC implements BaseBloC {
  final _loginState = StreamController<bool>();
  final _signUpState = StreamController<bool>();
  final _isLoadingState = StreamController<bool>();
  final _signUpBtnState = StreamController<bool>();
  final _signInBtnState = StreamController<bool>();

  Stream<bool> get loginStateStream => _loginState.stream;
  Stream<bool> get signUpStateStream => _signUpState.stream;
  Stream<bool> get signInBtnStateStream => _signInBtnState.stream;
  Stream<bool> get signUpStateBtnStream => _signUpBtnState.stream;
  Stream<bool> get isLoadingStateStream => _isLoadingState.stream;

  AuthBloC() {
    _loginState.sink.add(true);
    _signUpState.sink.add(false);
    _isLoadingState.sink.add(false);
    _signInBtnState.sink.add(false);
    _signUpBtnState.sink.add(true);
  }

  void setLoginState(val) {
    _loginState.sink.add(val);
    _signUpState.sink.add(false);
    _signInBtnState.sink.add(false);
    _signUpBtnState.sink.add(true);
  }

  void setSignUpState(val) {
    _signUpState.sink.add(val);
    _loginState.sink.add(false);
    _signInBtnState.sink.add(true);
    _signUpBtnState.sink.add(false);
  }

  void setIsLoadingState(val) {
    _isLoadingState.sink.add(val);
    print('sink ' + val.toString());
  }

  @override
  void dispose() {
    _loginState?.close();
    _signUpState?.close();
    _isLoadingState?.close();
    _signInBtnState?.close();
    _signUpBtnState?.close();
  }
}
