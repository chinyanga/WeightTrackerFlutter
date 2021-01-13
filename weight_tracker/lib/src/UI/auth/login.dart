import 'package:flutter/material.dart';
import 'package:weight_tracker/src/BloC/login_bloc.dart';
import 'package:weight_tracker/src/UI/colors/colors.dart';
import 'package:weight_tracker/src/BLoC/auth_bloc.dart';
import 'package:weight_tracker/src/models/user.dart';
import 'package:weight_tracker/src/ui/home.dart';

class Login extends StatefulWidget {
  final AuthBloC bloc;
  Login({Key key, @required this.bloc}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  final loginBloc = LoginBloC();
  bool loginFailed = false;

  @override
  void initState() {
    super.initState();
    this.widget.bloc.setIsLoadingState(false);
  }

  @override
  void dispose() {
    loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('Weight Tracker',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.darkBlue)),
            loginFailed
                ? Text('Login failed',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.red))
                : Container(),
            SizedBox(height: 20),
            StreamBuilder<String>(
                stream: loginBloc.username,
                builder: (context, snapshot) => TextField(
                      onChanged: loginBloc.usernameChanged,
                      controller: usernameController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          hintText: 'username',
                          errorText: snapshot.error,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(150.0))),
                    )),
            SizedBox(height: 5),
            StreamBuilder<String>(
                stream: loginBloc.password,
                builder: (context, snapshot) => TextField(
                      onChanged: loginBloc.passwordChanged,
                      controller: pwdController,
                      obscureText: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          hintText: 'password',
                          errorText: snapshot.error,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(150.0))),
                    )),
            SizedBox(height: 3),
            StreamBuilder<bool>(
                stream: loginBloc.loginCheck,
                builder: (context, snapshot) => RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      onPressed: snapshot.hasData
                          ? () async {
                              this.widget.bloc.setIsLoadingState(true);
                              Navigator.pushReplacementNamed(context, "/home");

                              /* await loginBloc
                                  .loginUser(User(
                                      username: usernameController.text.trim(),
                                      pwd: pwdController.text.trim()))
                                  .then((token) async {
                                Navigator.pushReplacementNamed(
                                    context, "/home");
                                this.widget.bloc.setIsLoadingState(false);
                                await loginBloc
                                    .storeToken(token.toString())
                                    .then((_) {
                                  if (token != null) {
                                    int id =
                                        loginBloc.decodeToken(token.toString());
                                    print('storing a token' + token.toString());
                                    this.widget.bloc.setIsLoadingState(false);
                                    Navigator.of(context).pushReplacement(
                                        new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                HomePage()));
                                  } else
                                    setState(() {
                                      loginFailed = true;
                                      this.widget.bloc.setIsLoadingState(false);
                                    });
                                });
                              });*/
                            }
                          : null,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: Text('Login',
                            style: TextStyle(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      color: AppColors.darkBlue,
                    ))
          ],
        ),
      ),
    );
  }
}
