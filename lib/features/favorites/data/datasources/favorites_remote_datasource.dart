import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/favorite_model.dart';

class FavoritesRemoteDataSource {
  final DioClient dioClient;

  FavoritesRemoteDataSource(this.dioClient);

  Future<List<FavoriteModel>> getFavorites() async {
    try {
      final response = await dioClient.get('/favorites');
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((item) => FavoriteModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      throw Exception('Failed to fetch favorites');
    } catch (e) {
      throw Exception('Error fetching favorites: $e');
    }
  }

  Future<List<FavoriteModel>> getUnfavorites() async {
    try {
      final response = await dioClient.get('/un-favorites');
      if (response.data['success'] == true) {
        final List<dynamic> data = response.data['data'] ?? [];
        return data.map((item) => FavoriteModel.fromJson(item as Map<String, dynamic>)).toList();
      }
      throw Exception('Failed to fetch unfavorites');
    } catch (e) {
      throw Exception('Error fetching unfavorites: $e');
    }
  }

  Future<bool> addFavorite(String bioUser) async {
    try {
      final response = await dioClient.post(
        '/favorites',
        data: {'bio_user': bioUser},
      );
      return response.data['success'] == true;
    } catch (e) {
      throw Exception('Error adding favorite: $e');
    }
  }

  Future<bool> removeFavorite(String bioUser) async {
    try {
      final response = await dioClient.post(
        '/un-favorites',
        data: {'bio_user': bioUser},
      );
      return response.data['success'] == true;
    } catch (e) {
      throw Exception('Error removing favorite: $e');
    }
  }
}
