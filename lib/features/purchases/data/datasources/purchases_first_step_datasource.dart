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

  Future<bool> updateBioChoiceStatus({
    required String userId,
    required String status,
  }) async {
    try {
      final response = await _dioClient.patch(
        '/bio-choice-data?type=status',
        data: {
          'user': userId,
          'status': status,
        },
      );
      
      return response.data['success'] == true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateBioChoiceFeedback({
    required String userId,
    required String feedback,
  }) async {
    if (userId.isEmpty) {
      print('Error: userId is empty in updateBioChoiceFeedback');
      return false;
    }
    
    try {
      print('Updating feedback for user: $userId');
      final response = await _dioClient.patch(
        '/bio-choice-data?type=feedback',
        data: {
          'user': userId,
          'feedback': feedback,
        },
      );
      
      return response.data['success'] == true;
    } catch (e) {
      print('Error updating feedback: $e');
      return false;
    }
  }
}
