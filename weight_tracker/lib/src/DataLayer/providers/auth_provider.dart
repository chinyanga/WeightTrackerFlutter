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
      final response = await http.post("$_apiBaseUrl/api/auth/signin");
      var jsonResponse = ApiBaseResponseHandler.returnResponse(response);
      return userFromJson(jsonResponse);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> registerUser(User user) async {
    try {
      final response = await http.get("$_apiBaseUrl/api/auth/signup");
      var jsonResponse = ApiBaseResponseHandler.returnResponse(response);
      return jsonResponse.body;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
