import '../../../../core/network/dio_client.dart';

class BioChoiceDatasource {
  final DioClient _dioClient;

  BioChoiceDatasource(this._dioClient);

  /// Check if already purchased (returns contact info if purchased)
  Future<Map<String, dynamic>?> checkIfPurchased({
    required String bioUser,
  }) async {
    try {
      final response = await _dioClient.get(
        '/bio-choice-data/check-second-step/$bioUser',
      );

      if (response.data['success'] == true) {
        return response.data['data'];
      }
      return null;
    } catch (e) {
      // 404 means not purchased yet, return null
      return null;
    }
  }

  /// Check bio choice status (pending/approved/rejected)
  Future<String?> checkBioChoiceStatus({
    required String bioUser,
  }) async {
    try {
      final response = await _dioClient.get(
        '/bio-choice-data/check-first-step/$bioUser',
      );

      if (response.data['success'] == true) {
        return response.data['data']?['status'];
      }
      return null;
    } catch (e) {
      // 404 means bio choice doesn't exist, return null
      return null;
    }
  }

  /// Create bio choice data (Step 1 - Send Request)
  Future<bool> createBioChoice({
    required String bioUser,
    String? bioDetails,
  }) async {
    try {
      final response = await _dioClient.post(
        '/bio-choice-data',
        data: {
          'bio_user': bioUser,
          'bio_details': bioDetails ?? 'মোবাইল এপ থেকে যোগাযোগের তথ্য দেখার অনুরোধ', // Request from mobile app
          // Don't send status - let backend set default 'pending'
        },
      );

      return response.data['success'] == true;
    } catch (e) {
      rethrow;
    }
  }
}
