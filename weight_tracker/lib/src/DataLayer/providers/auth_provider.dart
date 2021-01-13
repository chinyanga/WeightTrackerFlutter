import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_exceptions.dart';
import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_response_handler.dart';
import 'package:weight_tracker/src/datalayer/apiBaseUrl.dart';
import 'package:weight_tracker/src/models/user.dart';

class AuthApiProvider {
  final _apiBaseUrl = ApiBaseUrl.apiBaseUrl;

  Future<User> loginUser(User user) async {
    try {
      print(userToJson(user));
      final response = await http.post("$_apiBaseUrl/api/auth/signin",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: userToJson(user));
      print(response.body);
      var jsonResponse = ApiBaseResponseHandler.returnResponse(response);
      return userFromJson(jsonResponse);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> registerUser(User user) async {
    try {
      print(userToJson(user));
      final response = await http.post("$_apiBaseUrl/api/auth/signup",
          headers: {
            HttpHeaders.contentTypeHeader: "application/json",
          },
          body: userToJson(user));
      var jsonResponse = ApiBaseResponseHandler.returnResponse(response);
      print(jsonResponse.body);
      return jsonResponse.body;
    } catch (e) {
      print(e);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
