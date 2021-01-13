import 'dart:async';

import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_response.dart';
import 'package:weight_tracker/src/DataLayer/repository/weight_repo.dart';
import 'package:weight_tracker/src/bloC/baseBloC.dart';
import 'package:weight_tracker/src/models/weight.dart';
import 'package:weight_tracker/src/validators/validators.dart';

class AddWeightBloC extends Object with Validators implements BaseBloC {
  WeightRepository _weightRepo = WeightRepository();
  final _isLoadingState = StreamController<bool>();
  final _addWeight = StreamController<ApiResponse<Weight>>();

  AddWeightBloC() {
    _isLoadingState.sink.add(true);
  }

  Stream<ApiResponse<dynamic>> get weightStream => _addWeight.stream;

  Future<dynamic> addWeight(Weight weight) async {
    _addWeight.sink.add(ApiResponse.loading('Adding user weights...'));
    _isLoadingState.sink.add(true);
    try {
      var response = await _weightRepo.addWeight(weight);
      _addWeight.sink.add(ApiResponse.completed(response));
      _isLoadingState.sink.add(false);
    } catch (e) {
      _addWeight.sink.add(ApiResponse.error(e.toString()));
      _isLoadingState.sink.add(false);
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _addWeight?.close();
    _isLoadingState?.close();
  }
}
