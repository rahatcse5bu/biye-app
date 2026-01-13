import '../../../../core/network/dio_client.dart';
import '../models/biodata_model.dart';

abstract class BiodataRemoteDataSource {
  Future<List<BiodataModel>> getBiodatas({
    int page = 1,
    int limit = 20,
    String? gender,
    String? maritalStatus,
    String? zilla,
    bool? isFeatured,
  });
  
  Future<BiodataModel> getBiodataById(String userId);
  
  Future<Map<String, dynamic>> getBiodataStats();
}

class BiodataRemoteDataSourceImpl implements BiodataRemoteDataSource {
  final DioClient dioClient;
  
  BiodataRemoteDataSourceImpl(this.dioClient);
  
  @override
  Future<List<BiodataModel>> getBiodatas({
    int page = 1,
    int limit = 20,
    String? gender,
    String? maritalStatus,
    String? zilla,
    bool? isFeatured,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    
    if (gender != null) queryParams['gender'] = gender;
    if (maritalStatus != null) queryParams['marital_status'] = maritalStatus;
    if (zilla != null) queryParams['zilla'] = zilla;
    if (isFeatured != null) queryParams['isFeatured'] = isFeatured;
    
    final response = await dioClient.get(
      '/general-info',
      queryParameters: queryParams,
    );
    
    final List<dynamic> data = response.data['data'] ?? [];
    return data.map((json) => BiodataModel.fromJson(json)).toList();
  }
  
  @override
  Future<BiodataModel> getBiodataById(String biodataId) async {
    try {
      // First, fetch the biodata from list to get the user_id
      final listResponse = await dioClient.get(
        '/general-info',
        queryParameters: {'_id': biodataId, 'limit': 1},
      );
      
      final List<dynamic> listData = listResponse.data['data'] ?? [];
      
      if (listData.isEmpty) {
        throw Exception('Biodata not found');
      }
      
      final generalInfoData = listData.first;
      final userId = generalInfoData['user_id']; // Get the integer user_id
      
      if (userId == null) {
        // Fallback: if no user_id, just return the general info
        print('No user_id found, returning general info only');
        return BiodataModel.fromJson(generalInfoData);
      }
      
      // Increment view count using watch endpoint
      try {
        await dioClient.get('/general-info/watch/$biodataId');
      } catch (e) {
        print('Watch endpoint failed: $e');
      }
      
      // Now fetch complete biodata with all nested data using user_id
      final bioDataResponse = await dioClient.get('/bio-data/$userId');
      
      print('Bio-data API Response: ${bioDataResponse.data}');
      
      final responseData = bioDataResponse.data['data'];
      
      if (responseData == null) {
        throw Exception('No data received from bio-data endpoint');
      }
      
      return _parseBiodataResponse(responseData);
    } catch (e, stackTrace) {
      print('Error in getBiodataById: $e');
      print('Stack trace: $stackTrace');
      rethrow;
    }
  }
  
  BiodataModel _parseBiodataResponse(dynamic responseData) {
    // Helper to check if a value is a non-empty Map
    bool isValidMap(dynamic value) {
      return value != null && value is Map && value.isNotEmpty;
    }
    
    // Check if response has nested structure (generalInfo wrapper)
    if (responseData is Map && responseData['generalInfo'] != null) {
      final generalInfo = Map<String, dynamic>.from(responseData['generalInfo']);
      
      // Add nested objects to generalInfo for parsing
      if (isValidMap(responseData['address'])) {
        generalInfo['address'] = responseData['address'];
      }
      if (isValidMap(responseData['educationQualification'])) {
        generalInfo['educationQualification'] = responseData['educationQualification'];
      }
      if (isValidMap(responseData['personalInfo'])) {
        generalInfo['personalInfo'] = responseData['personalInfo'];
      }
      if (isValidMap(responseData['familyStatus'])) {
        generalInfo['familyStatus'] = responseData['familyStatus'];
      }
      if (isValidMap(responseData['occupation'])) {
        generalInfo['occupation'] = responseData['occupation'];
      }
      if (isValidMap(responseData['maritalInfo'])) {
        generalInfo['maritalInfo'] = responseData['maritalInfo'];
      }
      if (isValidMap(responseData['expectedLifePartner'])) {
        generalInfo['expectedLifePartner'] = responseData['expectedLifePartner'];
      }
      
      print('Parsed biodata with nested data');
      return BiodataModel.fromJson(generalInfo);
    }
    
    // Otherwise parse directly (list endpoint format)
    return BiodataModel.fromJson(responseData as Map<String, dynamic>);
  }
  
  @override
  Future<Map<String, dynamic>> getBiodataStats() async {
    final response = await dioClient.get('/bio_data/stats');
    return response.data['data'];
  }
}
