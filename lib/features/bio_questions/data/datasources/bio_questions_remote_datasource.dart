import '../../../../core/network/dio_client.dart';
import '../models/bio_questions_model.dart';

class BioQuestionsRemoteDataSource {
  final DioClient _dioClient;

  BioQuestionsRemoteDataSource(this._dioClient);

  /// Get questions by user ID (public - for buyers viewing questions)
  Future<BioQuestionsModel?> getQuestionsByUser(String userId) async {
    try {
      final response = await _dioClient.get('/bio-questions/user/$userId');
      
      if (response.data['success'] == true && response.data['data'] != null) {
        final data = response.data['data'];
        
        // Check if this is a proper BioQuestion document with user field
        if (data['user'] != null) {
          return BioQuestionsModel.fromJson(data);
        }
        
        // If it's default questions response, create a model with just questions
        if (data['questions'] != null && data['questions'] is List) {
          return BioQuestionsModel(
            user: userId,
            questions: (data['questions'] as List<dynamic>)
                .map((e) => e as String)
                .toList(),
          );
        }
      }
      
      return null;
    } catch (e) {
      rethrow;
    }
  }

  /// Get my questions (authenticated - for biodata owner)
  Future<BioQuestionsModel?> getMyQuestions() async {
    try {
      final response = await _dioClient.get('/bio-questions/my-questions');
      
      print('🔍 Raw response: ${response.data}');
      
      if (response.data == null) {
        return null;
      }
      
      // Handle different response formats
      final dynamic responseData = response.data;
      
      // Check if response has success flag
      if (responseData is Map<String, dynamic>) {
        final success = responseData['success'];
        final data = responseData['data'];
        
        if (success == true && data != null) {
          // Check if this is a proper BioQuestion document with user field
          if (data is Map<String, dynamic> && data['user'] != null) {
            return BioQuestionsModel.fromJson(data);
          }
          
          // If data only has questions array (default questions)
          if (data is Map<String, dynamic> && data['questions'] != null) {
            return null; // Return null so UI loads defaults
          }
        }
      }
      
      return null;
    } catch (e) {
      print('❌ Error in getMyQuestions: $e');
      rethrow;
    }
  }

  /// Create or update questions (upsert)
  Future<BioQuestionsModel> upsertQuestions(List<String> questions) async {
    try {
      final response = await _dioClient.post(
        '/bio-questions',
        data: {'questions': questions},
      );
      
      if (response.data['success'] == true) {
        return BioQuestionsModel.fromJson(response.data['data']);
      }
      
      throw Exception(response.data['message'] ?? 'Failed to save questions');
    } catch (e) {
      rethrow;
    }
  }

  /// Delete all my questions
  Future<void> deleteQuestions() async {
    try {
      final response = await _dioClient.delete('/bio-questions');
      
      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to delete questions');
      }
    } catch (e) {
      rethrow;
    }
  }
}
