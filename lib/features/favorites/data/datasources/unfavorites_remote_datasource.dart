import '../../../../core/network/dio_client.dart';
import '../models/unfavorite_model.dart';

class UnfavoritesRemoteDataSource {
  final DioClient _dioClient;

  UnfavoritesRemoteDataSource(this._dioClient);

  Future<List<UnfavoriteModel>> getUnfavorites() async {
    try {
      final response = await _dioClient.get('/un-favorites');
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => UnfavoriteModel.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      // Return empty list if endpoint doesn't exist or error occurs
      return [];
    }
  }
}
