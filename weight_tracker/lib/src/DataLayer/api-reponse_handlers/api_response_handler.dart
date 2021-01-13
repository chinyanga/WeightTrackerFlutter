import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiBaseResponseHandler {
  static dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException('${response.statusCode}');
    }
  }
}
