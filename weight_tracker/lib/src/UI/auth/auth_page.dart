import "package:flutter/material.dart";
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:weight_tracker/src/UI/colors/colors.dart';
import 'package:weight_tracker/src/BLoC/auth_bloc.dart';
import 'package:weight_tracker/src/UI/auth/login.dart';
import 'package:weight_tracker/src/UI/auth/signup.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final authBloC = AuthBloC();
  @override
  void dispose() {
    print("Disposing auth main state");
    authBloC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: authBloC.isLoadingStateStream,
        builder: (context, loadingSnapShot) {
          return ModalProgressHUD(
            child: WillPopScope(
                onWillPop: () async => false,
                child: Scaffold(
                  body: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder<bool>(
                              stream: authBloC.loginStateStream,
                              builder: (context, snapshot) {
                                print("Varibale for login ${snapshot.data}");
                                return snapshot.hasData && snapshot.data
                                    ? Login(bloc: authBloC)
                                    : Container();
                              }),
                          StreamBuilder<bool>(
                              stream: authBloC.signUpStateStream,
                              builder: (context, snapshot) {
                                print(
                                    "Varibale for sign up pwd ${snapshot.data}");
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: snapshot.hasData && snapshot.data
                                        ? SignUp(isSignUp: true, bloc: authBloC)
                                        : Container());
                              }),
                          StreamBuilder<bool>(
                              stream: authBloC.signInBtnStateStream,
                              builder: (context, snapshot) {
                                return snapshot.hasData && snapshot.data
                                    ? FlatButton(
                                        onPressed: () {
                                          authBloC.setIsLoadingState(true);
                                          authBloC.setLoginState(true);
                                        },
                                        child: Text('Login',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.darkBlue)),
                                      )
                                    : Container();
                              }),
                          StreamBuilder<bool>(
                              stream: authBloC.signUpStateBtnStream,
                              builder: (context, snapshot) {
                                return snapshot.hasData && snapshot.data
                                    ? FlatButton(
                                        onPressed: () {
                                          authBloC.setSignUpState(true);
                                        },
                                        child: Text('Register',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors.darkBlue)),
                                      )
                                    : Container();
                              }),
                        ],
                      ),
                    ),
                  ),
                )),
            inAsyncCall:
                loadingSnapShot.data != null ? loadingSnapShot.data : false,
            color: Colors.transparent,
            dismissible: false,
            progressIndicator: CircularProgressIndicator(),
          );
        });
  }
}
