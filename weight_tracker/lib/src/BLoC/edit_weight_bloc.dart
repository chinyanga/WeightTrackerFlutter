import 'dart:async';

import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_response.dart';
import 'package:weight_tracker/src/DataLayer/repository/weight_repo.dart';
import 'package:weight_tracker/src/bloC/baseBloC.dart';
import 'package:weight_tracker/src/models/weight.dart';
import 'package:weight_tracker/src/validators/validators.dart';

class EditWeightBloC extends Object with Validators implements BaseBloC {
  WeightRepository _weightRepo = WeightRepository();
  final _isLoadingState = StreamController<bool>();
  final _editWeight = StreamController<ApiResponse<Weight>>();

  EditWeightBloC() {
    _isLoadingState.sink.add(true);
  }

  Stream<ApiResponse<dynamic>> get weightStream => _editWeight.stream;

  Future<dynamic> editWeight(Weight weight) async {
    _editWeight.sink.add(ApiResponse.loading('Editing user weights...'));
    _isLoadingState.sink.add(true);
    try {
      var response = await _weightRepo.updateWeight(weight);
      _editWeight.sink.add(ApiResponse.completed(response));
      _isLoadingState.sink.add(false);
    } catch (e) {
      _editWeight.sink.add(ApiResponse.error(e.toString()));
      _isLoadingState.sink.add(false);
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _editWeight?.close();
    _isLoadingState?.close();
  }
}
