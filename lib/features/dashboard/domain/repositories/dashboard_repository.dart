import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/models/dashboard_stats_model.dart';

abstract class DashboardRepository {
  Future<DashboardStatsModel> getDashboardData(String userId, double userPoints);
  Future<Map<String, dynamic>> getBioStatistics(String userId);
}

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl({required this.remoteDataSource});

  @override
  Future<DashboardStatsModel> getDashboardData(String userId, double userPoints) async {
    try {
      return await remoteDataSource.getDashboardData(userId, userPoints);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getBioStatistics(String userId) async {
    try {
      return await remoteDataSource.getBioStatistics(userId);
    } catch (e) {
      rethrow;
    }
  }
}
