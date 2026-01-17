import '../../../../core/network/dio_client.dart';
import '../models/liked_by_model.dart';

class LikedByRemoteDataSource {
  final DioClient _dioClient;

  LikedByRemoteDataSource(this._dioClient);

  Future<List<LikedByModel>> getLikedBy() async {
    try {
      final response = await _dioClient.get('/liked-by');
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => LikedByModel.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      // Return empty list if endpoint doesn't exist or error occurs
      // Backend endpoint may not be implemented yet
      return [];
    }
  }
}
