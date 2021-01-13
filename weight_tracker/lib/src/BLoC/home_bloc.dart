import 'dart:async';

import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_response.dart';
import 'package:weight_tracker/src/DataLayer/repository/weight_repo.dart';
import 'package:weight_tracker/src/bloC/baseBloC.dart';
import 'package:weight_tracker/src/models/weight.dart';
import 'package:weight_tracker/src/validators/validators.dart';

class HomeBloC extends Object with Validators implements BaseBloC {
  WeightRepository _weightRepo = WeightRepository();

  final _weightList = StreamController<ApiResponse<List<Weight>>>();

  List<Weight> allUserWeight = [];

  Stream<ApiResponse<List<Weight>>> get weightListStream => _weightList.stream;

  fetchListOfAllUserWeights(int userId) async {
    _weightList.sink.add(ApiResponse.loading('Fetching user weights...'));
    try {
      List<Weight> response = await _weightRepo.getUserWeights(userId);
      allUserWeight = response;
      _weightList.sink.add(ApiResponse.completed(response));
    } catch (e) {
      _weightList.sink.add(ApiResponse.error(e.toString()));
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _weightList?.close();
  }
}
