import '../../../../core/network/dio_client.dart';
import '../models/purchase_second_step_model.dart';

class PurchasesSecondStepDataSource {
  final DioClient _dioClient;

  PurchasesSecondStepDataSource(this._dioClient);

  Future<List<PurchaseSecondStepModel>> getSecondStepPurchases() async {
    try {
      final response = await _dioClient.get('/bio-choice-data/second-step');
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => PurchaseSecondStepModel.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }
}
