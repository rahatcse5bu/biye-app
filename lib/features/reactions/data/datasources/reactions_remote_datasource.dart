import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/reaction_model.dart';

class ReactionsRemoteDataSource {
  final DioClient dioClient;

  ReactionsRemoteDataSource(this.dioClient);

  /// Toggle reaction for a biodata
  Future<ReactionModel?> toggleReaction({
    required String bioUserId,
    required ReactionType reactionType,
  }) async {
    try {
      final response = await dioClient.dio.post(
        '/reactions/toggle',
        data: {
          'bio_user': bioUserId,
          'reaction_type': reactionType.toJson(),
        },
      );
      
      if (response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return ReactionModel.fromJson(data as Map<String, dynamic>);
        }
        return null; // Reaction was removed
      }
      throw Exception('Failed to toggle reaction');
    } catch (e) {
      throw Exception('Error toggling reaction: $e');
    }
  }

  /// Get reaction counts for a specific biodata
  Future<List<ReactionCountModel>> getReactionCounts(String bioUserId) async {
    try {
      final response = await dioClient.dio.get(
        '/reactions/counts/$bioUserId',
      );
      
      if (response.data['success'] == true) {
        final Map<String, dynamic> data = response.data['data'] ?? {};
        // API returns object format: {"like": 0, "love": 1, ...}
        return data.entries.map((entry) {
          return ReactionCountModel(
            reactionType: ReactionType.fromJson(entry.key),
            count: entry.value as int,
          );
        }).toList();
      }
      throw Exception('Failed to fetch reaction counts');
    } catch (e) {
      throw Exception('Error fetching reaction counts: $e');
    }
  }

  /// Get my reactions list (all reactions I've made)
  Future<List<ReactionModel>> getMyReactions({ReactionType? reactionType}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (reactionType != null) {
        queryParams['reaction_type'] = reactionType.toJson();
      }
      
      final response = await dioClient.dio.get(
        '/reactions/my-reactions',
        queryParameters: queryParams,
      );
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((item) => ReactionModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      throw Exception('Failed to fetch my reactions');
    } catch (e) {
      throw Exception('Error fetching my reactions: $e');
    }
  }

  /// Get my reaction for a specific biodata
  Future<ReactionModel?> getMyReactionForBio(String bioUserId) async {
    try {
      final response = await dioClient.dio.get(
        '/reactions/user-reaction/$bioUserId',
      );
      
      if (response.data['success'] == true) {
        final data = response.data['data'];
        if (data != null) {
          return ReactionModel.fromJson(data as Map<String, dynamic>);
        }
        return null; // No reaction found
      }
      return null;
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 404) {
        return null; // No reaction found
      }
      throw Exception('Error fetching my reaction: $e');
    }
  }

  /// Get list of biodatas with specific reaction type
  Future<List<ReactionModel>> getReactionsByType(ReactionType reactionType) async {
    try {
      final response = await dioClient.dio.get(
        '/reactions/my-reactions',
        queryParameters: {'reaction_type': reactionType.toJson()},
      );
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((item) => ReactionModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      throw Exception('Failed to fetch reactions by type');
    } catch (e) {
      throw Exception('Error fetching reactions by type: $e');
    }
  }

  /// Get reactions received by the user (who reacted to my biodata)
  Future<List<ReactionModel>> getReactionsReceived({ReactionType? reactionType}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (reactionType != null) {
        queryParams['reaction_type'] = reactionType.toJson();
      }
      
      final response = await dioClient.dio.get(
        '/reactions/reactions-to-me',
        queryParameters: queryParams,
      );
      
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((item) => ReactionModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      throw Exception('Failed to fetch received reactions');
    } catch (e) {
      throw Exception('Error fetching received reactions: $e');
    }
  }
}
