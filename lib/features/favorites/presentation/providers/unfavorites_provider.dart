import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/unfavorites_remote_datasource.dart';
import '../../data/datasources/disliked_by_remote_datasource.dart';
import '../../data/models/unfavorite_model.dart';
import '../../data/models/disliked_by_model.dart';

// Datasource Provider
final unfavoritesRemoteDataSourceProvider = Provider<UnfavoritesRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UnfavoritesRemoteDataSource(dioClient);
});

// Disliked By Datasource Provider
final dislikedByRemoteDataSourceProvider = Provider<DislikedByRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DislikedByRemoteDataSource(dioClient);
});

// Unfavorites List Provider
final unfavoritesProvider = FutureProvider<List<UnfavoriteModel>>((ref) async {
  final dataSource = ref.watch(unfavoritesRemoteDataSourceProvider);
  return await dataSource.getUnfavorites();
});

// Disliked By List Provider
final dislikedByProvider = FutureProvider<List<DislikedByModel>>((ref) async {
  final dataSource = ref.watch(dislikedByRemoteDataSourceProvider);
  return await dataSource.getDislikedBy();
});
