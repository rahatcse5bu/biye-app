import '../../../../core/network/dio_client.dart';
import '../models/biodata_model.dart';

abstract class BiodataRemoteDataSource {
  Future<List<BiodataModel>> getBiodatas({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
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
    Map<String, dynamic>? filters,
  }) async {
    final queryParams = <String, dynamic>{
      'page': page,
      'limit': limit,
    };
    
    // Add all filter parameters
    if (filters != null) {
      filters.forEach((key, value) {
        if (value != null) {
          queryParams[key] = value;
        }
      });
    }
    
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
      print('🔍 Fetching biodata for ID: $biodataId');
      
      // First, fetch from general-info to get the user_id
      print('📡 Step 1: Fetching from general-info to get user_id');
      final listResponse = await dioClient.get(
        '/general-info',
        queryParameters: {
          'page': 1,
          'limit': 100, // Get more results to search through
          '_t': DateTime.now().millisecondsSinceEpoch,
        },
      );
      
      final List<dynamic> listData = listResponse.data['data'] ?? [];
      
      // Find the biodata by _id
      final biodataItem = listData.firstWhere(
        (item) => item['_id'] == biodataId,
        orElse: () => null,
      );
      
      if (biodataItem == null) {
        throw Exception('Biodata not found with _id: $biodataId');
      }
      
      final userId = biodataItem['user_id'];
      
      if (userId == null) {
        print('⚠️ No user_id found, returning general info only');
        return BiodataModel.fromJson(biodataItem);
      }
      
      print('👤 Found user_id: $userId for biodata_id: $biodataId');
      
      // Increment view count using watch endpoint
      try {
        await dioClient.get('/general-info/watch/$biodataId');
      } catch (e) {
        print('⚠️ Watch endpoint failed: $e');
      }
      
      // Now fetch complete biodata with all nested data using user_id
      print('📡 Step 2: Fetching complete bio-data for user_id: $userId');
      final bioDataResponse = await dioClient.get(
        '/bio-data/$userId',
        queryParameters: {
          '_t': DateTime.now().millisecondsSinceEpoch,
        },
      );
      
      print('✅ Bio-data API Response received for user_id: $userId');
      
      final responseData = bioDataResponse.data['data'];
      
      if (responseData == null) {
        throw Exception('No data received from bio-data endpoint');
      }
      
      final parsedModel = _parseBiodataResponse(responseData);
      print('✅ Successfully parsed biodata for user_id: $userId, biodata_id: ${parsedModel.id}');
      
      return parsedModel;
    } catch (e, stackTrace) {
      print('❌ Error in getBiodataById: $e');
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
    final response = await dioClient.get('/bio-data/stats');
    return response.data['data'];
  }
}
