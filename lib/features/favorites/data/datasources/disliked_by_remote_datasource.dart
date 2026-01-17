import '../../../../core/network/dio_client.dart';
import '../models/disliked_by_model.dart';

class DislikedByRemoteDataSource {
  final DioClient _dioClient;

  DislikedByRemoteDataSource(this._dioClient);

  Future<List<DislikedByModel>> getDislikedBy() async {
    try {
      final response = await _dioClient.get('/disliked-by');
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => DislikedByModel.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      // Return empty list if endpoint doesn't exist or error occurs
      // Backend endpoint may not be implemented yet
      return [];
    }
  }
}
