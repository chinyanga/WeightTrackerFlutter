import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import "package:flutter/material.dart";
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:weight_tracker/src/BLoC/auth_bloc.dart';
import 'package:weight_tracker/src/UI/colors/colors.dart';
import 'package:weight_tracker/src/BloC/signup_bloc.dart';
import 'package:weight_tracker/src/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class SignUp extends StatefulWidget {
  final bool isSignUp;
  final AuthBloC bloc;
  SignUp({
    Key key,
    @required this.isSignUp,
    @required this.bloc,
  }) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  TextEditingController cpwdController = new TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");
  User user;
  final signUpBloc = SignUpBloC();
  var msg = "Weight Tracker\n Register by completing the form below";
  bool regSuccessful = false;
  bool regFail = false;
  var error = 'Try again';
  int weight = 30;
  int targetWeight = 65;
  DateTime dob = DateTime.now();

  @override
  void initState() {
    super.initState();
    print(this.widget.isSignUp);
    this.widget.bloc.setIsLoadingState(false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text('$msg',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: AppColors.darkBlue)),
            regSuccessful
                ? Text('You are successfully registered',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.green))
                : Container(),
            regFail
                ? Text('Registration failed +$error',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red))
                : Container(),
            SizedBox(height: 20),
            StreamBuilder<String>(
                stream: signUpBloc.username,
                builder: (context, snapshot) => TextField(
                      onChanged: signUpBloc.usernameChanged,
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
                stream: signUpBloc.password,
                builder: (context, snapshot) => TextField(
                      onChanged: signUpBloc.passwordChanged,
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
            SizedBox(height: 5),
            StreamBuilder<String>(
                stream: signUpBloc.comfirmPassword,
                builder: (context, snapshot) => TextField(
                      onChanged: signUpBloc.confirmpwdChanged,
                      obscureText: true,
                      controller: cpwdController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                          hintText: 'confirm password',
                          errorText: snapshot.error,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(150.0))),
                    )),
            Row(
              children: [
                Text('Select Date'),
                Container(
                  width: 250,
                  child: DateTimeField(
                    format: dateFormat,
                    onChanged: (selectedDate) => dob = selectedDate,
                    onShowPicker: (context, currentValue) {
                      return showDatePicker(
                          context: context,
                          firstDate: DateTime(1900),
                          initialDate: currentValue ?? dob,
                          lastDate: DateTime(2100));
                    },
                  ),
                ),
              ],
            ),
            Padding(
              child: Row(
                children: [
                  Text('Weight'),
                  Container(
                      width: 250,
                      child: SpinBox(
                        max: 200.0,
                        min: 0.0,
                        value: weight.toDouble(),
                        decimals: 1,
                        step: 0.1,
                        onChanged: (w) => weight = w.toInt(),
                      )),
                ],
              ),
              padding: const EdgeInsets.all(16),
            ),
            Padding(
              child: Row(
                children: [
                  Text('Target Weight'),
                  Container(
                      width: 200,
                      child: SpinBox(
                        max: 300.0,
                        min: 0.0,
                        value: targetWeight.toDouble(),
                        decimals: 1,
                        step: 0.1,
                        onChanged: (tagW) => targetWeight = tagW.toInt(),
                      )),
                ],
              ),
              padding: const EdgeInsets.all(16),
            ),
            SizedBox(height: 5),
            StreamBuilder<bool>(
                stream: signUpBloc.registerCheck,
                builder: (context, snapshot) => RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      onPressed: snapshot.hasData
                          ? () async {
                              this.widget.bloc.setIsLoadingState(true);
                              print('Registering');
                              await signUpBloc
                                  .registerUser(User(
                                      username: usernameController.text.trim(),
                                      pwd: pwdController.text.trim(),
                                      weight: weight,
                                      target_weight: targetWeight.toInt(),
                                      dob: dob))
                                  .then((user) async {
                                print(user);
                                if (user != null) {
                                  print('Registered');
                                  setState(() {
                                    regSuccessful = true;
                                    this.widget.bloc.setIsLoadingState(false);
                                  });
                                } else
                                  setState(() {
                                    regFail = true;
                                    regSuccessful = false;
                                    this.widget.bloc.setIsLoadingState(false);
                                  });
                              }).catchError((e) {
                                this.widget.bloc.setIsLoadingState(false);
                                print('Registering');
                              }).timeout(const Duration(minutes: 1));
                            }
                          : null,
                      child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text('Register',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold))),
                      color: AppColors.darkBlue,
                    ))
          ],
        ),
      ),
    );
  }
}
