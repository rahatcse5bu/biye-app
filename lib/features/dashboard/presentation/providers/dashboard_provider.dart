import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/dashboard_remote_datasource.dart';
import '../../data/models/dashboard_stats_model.dart';
import '../../domain/repositories/dashboard_repository.dart';
import '../../../auth/presentation/providers/auth_provider.dart';

// Dashboard Remote Data Source Provider
final dashboardRemoteDataSourceProvider = Provider<DashboardRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DashboardRemoteDataSourceImpl(dioClient: dioClient);
});

// Dashboard Repository Provider
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final remoteDataSource = ref.watch(dashboardRemoteDataSourceProvider);
  return DashboardRepositoryImpl(remoteDataSource: remoteDataSource);
});

// Dashboard State Provider
final dashboardStatsProvider = FutureProvider.autoDispose<DashboardStatsModel>((ref) async {
  final repository = ref.watch(dashboardRepositoryProvider);
  final authState = ref.watch(authNotifierProvider);

  return authState.maybeWhen(
    authenticated: (user) async {
      return await repository.getDashboardData(user.id, user.points.toDouble());
    },
    orElse: () async {
      return DashboardStatsModel.empty();
    },
  );
});
