import '../../../../core/network/dio_client.dart';
import '../models/dashboard_stats_model.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardStatsModel> getDashboardData(String userId, double userPoints);
  Future<Map<String, dynamic>> getBioStatistics(String userId);
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final DioClient dioClient;

  DashboardRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<DashboardStatsModel> getDashboardData(String userId, double userPoints) async {
    try {
      // API: /api/v1/general-info/dash-board
      final response = await dioClient.get('/general-info/dash-board');

      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to fetch dashboard data');
      }

      // Also get bio statistics
      final bioStatsResponse = await dioClient.get('/bio-choice-data/statistics/$userId');

      if (bioStatsResponse.data['success'] != true) {
        throw Exception(bioStatsResponse.data['message'] ?? 'Failed to fetch bio statistics');
      }

      final dashboardData = response.data['data'] ?? {};
      final bioStats = bioStatsResponse.data['results'] ?? {};

      // Calculate total proposals (pending + approved + rejected)
      final pending = bioStats['pending'] ?? 0;
      final approved = bioStats['approved'] ?? 0;
      final rejected = bioStats['rejected'] ?? 0;
      final total = pending + approved + rejected;

      // Merge both responses into one model
      final combinedData = {
        'points': userPoints, // Use points from authenticated user
        'likes_count': dashboardData['likes_count'] ?? 0,
        'views_count': dashboardData['views_count'] ?? 0,
        'favorite_count': dashboardData['favorite_count'] ?? 0,
        'unFavorite_count': dashboardData['unFavorite_count'] ?? 0,
        'contact_purchase_count': dashboardData['contact_purchase_count'] ?? 0,
        'pending': pending,
        'total': total,
        'approvedPercentage': double.tryParse(bioStats['approvedPercentage']?.toString() ?? '0') ?? 0.0,
        'rejectedPercentage': double.tryParse(bioStats['rejectedPercentage']?.toString() ?? '0') ?? 0.0,
      };

      return DashboardStatsModel.fromJson(combinedData);
    } catch (e) {
      throw Exception('Failed to fetch dashboard data: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getBioStatistics(String userId) async {
    try {
      // API: /api/v1/bio-choice-data/statistics/:bio_user
      final response = await dioClient.get('/bio-choice-data/statistics/$userId');

      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to fetch bio statistics');
      }

      return response.data['results'];
    } catch (e) {
      throw Exception('Failed to fetch bio statistics: $e');
    }
  }
}
