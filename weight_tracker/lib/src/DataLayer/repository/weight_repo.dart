import 'package:weight_tracker/src/datalayer/providers/weight_provider.dart';
import 'package:weight_tracker/src/models/weight.dart';

class WeightRepository {
  WeightApiProvider weightApiProvider = WeightApiProvider();

  Future<List<Weight>> getUserWeights(int userId) =>
      weightApiProvider.fetchAllWeightByUser(userId);

  Future<Weight> updateWeights(Weight weight) =>
      weightApiProvider.updateWeight(weight);

  Future<Weight> addWeight(Weight weight) =>
      weightApiProvider.addWeight(weight);

  Future<dynamic> deleteWeight(int id) =>
      weightApiProvider.deleteWeightById(id);
}
