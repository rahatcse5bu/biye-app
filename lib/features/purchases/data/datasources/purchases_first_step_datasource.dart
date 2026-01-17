import '../../../../core/network/dio_client.dart';
import '../models/purchase_first_step_model.dart';

class PurchasesRemoteDataSource {
  final DioClient _dioClient;

  PurchasesRemoteDataSource(this._dioClient);

  Future<List<PurchaseFirstStepModel>> getFirstStepPurchases() async {
    try {
      final response = await _dioClient.get('/bio-choice-data/first-step');
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => PurchaseFirstStepModel.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }
}
