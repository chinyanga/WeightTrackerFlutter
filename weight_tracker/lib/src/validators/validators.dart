import 'dart:async';

mixin Validators {
  var usernameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.length >= 5) {
      sink.add(username);
    } else {
      sink.addError("Username should be atleast 5 chars.");
    }
  });

  var passwordValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError("Password should be atleast 6 chars.");
    }
  });
}
