import '../../../../core/network/dio_client.dart';
import '../models/bio_share_model.dart';

class BioRequestsRemoteDataSource {
  final DioClient _dioClient;

  BioRequestsRemoteDataSource(this._dioClient);

  Future<List<BioShareModel>> getBioRequests() async {
    try {
      final response = await _dioClient.get('/bio-choice-data/bio-share');
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((json) => BioShareModel.fromJson(json)).toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }

  Future<bool> updateBioRequestStatus({
    required String userId,
    required String status,
    String? feedback,
  }) async {
    try {
      final response = await _dioClient.put(
        '/bio-choice-data?type=feedback',
        data: {
          'user': userId,
          'status': status,
          if (feedback != null && feedback.isNotEmpty) 'feedback': feedback,
        },
      );
      
      return response.data['success'] == true;
    } catch (e) {
      return false;
    }
  }
}
