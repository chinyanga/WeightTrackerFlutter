import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_exceptions.dart';
import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_response_handler.dart';
import 'package:weight_tracker/src/DataLayer/apiBaseUrl.dart';

import 'package:weight_tracker/src/models/weight.dart';

class WeightApiProvider {
  final _apiBaseUrl = ApiBaseUrl.apiBaseUrl;

  Future<List<Weight>> fetchAllWeightByUser(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "x-access-token": token,
    };
    try {
      print(token);
      final response = await http.get(
          "$_apiBaseUrl/api/userweights?user_id=$userId",
          headers: headers);
      var jsonResponse = ApiBaseResponseHandler.returnResponse(response);
      return weightListFromJson(jsonResponse);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<Weight> updateWeight(Weight weight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "x-access-token": token,
    };
    try {
      final response = await http.put("$_apiBaseUrl/api/editweight",
          headers: headers, body: weightToJson(weight));
      var jsonResponse = ApiBaseResponseHandler.returnResponse(response);
      return weightFromJson(jsonResponse);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> deleteWeightById(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "x-access-token": token,
    };
    try {
      final response = await http.delete("$_apiBaseUrl/api/deleteweight?id=$id",
          headers: headers);
      var jsonResponse = ApiBaseResponseHandler.returnResponse(response);
      return jsonResponse;
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }

  Future<Weight> addWeight(Weight weight) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json",
      "x-access-token": token,
    };
    try {
      print(weightToJson(weight));
      final response = await http.post("$_apiBaseUrl/api/addweight",
          headers: headers, body: weightToJson(weight));
      var jsonResponse = ApiBaseResponseHandler.returnResponse(response);
      print(response.body);
      return weightFromJson(jsonResponse);
    } catch (e) {
      print(e);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
  }
}
