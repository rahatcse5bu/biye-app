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
}
