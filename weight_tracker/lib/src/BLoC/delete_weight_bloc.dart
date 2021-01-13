import 'dart:async';

import 'package:weight_tracker/src/DataLayer/api-reponse_handlers/api_response.dart';
import 'package:weight_tracker/src/DataLayer/repository/weight_repo.dart';
import 'package:weight_tracker/src/bloC/baseBloC.dart';
import 'package:weight_tracker/src/validators/validators.dart';

class DeleteWeightBloC extends Object with Validators implements BaseBloC {
  WeightRepository _weightRepo = WeightRepository();
  final _isLoadingState = StreamController<bool>();
  final _deleteWeight = StreamController<ApiResponse<dynamic>>();

  DeleteWeightBloC() {
    _isLoadingState.sink.add(true);
  }

  Stream<ApiResponse<dynamic>> get weightStream => _deleteWeight.stream;

  deleteWeight(int weightId) async {
    _deleteWeight.sink.add(ApiResponse.loading('Deleting user weights...'));
    _isLoadingState.sink.add(true);
    try {
      var response = await _weightRepo.deleteWeight(weightId);
      _deleteWeight.sink.add(ApiResponse.completed(response));
      _isLoadingState.sink.add(false);
    } catch (e) {
      _deleteWeight.sink.add(ApiResponse.error(e.toString()));
      _isLoadingState.sink.add(false);
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _deleteWeight?.close();
    _isLoadingState?.close();
  }
}
