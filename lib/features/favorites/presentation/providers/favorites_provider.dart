import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/favorites_remote_datasource.dart';
import '../../data/datasources/liked_by_remote_datasource.dart';
import '../../data/models/favorite_model.dart';
import '../../data/models/liked_by_model.dart';

// Datasource Provider
final favoritesRemoteDataSourceProvider = Provider<FavoritesRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FavoritesRemoteDataSource(dioClient);
});

// Liked By Datasource Provider
final likedByRemoteDataSourceProvider = Provider<LikedByRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LikedByRemoteDataSource(dioClient);
});

// Favorites List Provider
final favoritesProvider = FutureProvider<List<FavoriteModel>>((ref) async {
  final dataSource = ref.watch(favoritesRemoteDataSourceProvider);
  return await dataSource.getFavorites();
});

// Liked By List Provider
final likedByProvider = FutureProvider<List<LikedByModel>>((ref) async {
  final dataSource = ref.watch(likedByRemoteDataSourceProvider);
  return await dataSource.getLikedBy();
});
