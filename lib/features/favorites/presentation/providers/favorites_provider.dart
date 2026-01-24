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

// Unfavorites List Provider
final unfavoritesProvider = FutureProvider<List<FavoriteModel>>((ref) async {
  final dataSource = ref.watch(favoritesRemoteDataSourceProvider);
  return await dataSource.getUnfavorites();
});

// Liked By List Provider
final likedByProvider = FutureProvider<List<LikedByModel>>((ref) async {
  final dataSource = ref.watch(likedByRemoteDataSourceProvider);
  return await dataSource.getLikedBy();
});
// Favorite Toggle State
class FavoriteToggleState {
  final bool isLoading;
  final String? errorMessage;
  final Set<String> favoritedBioUsers; // Track favorited (liked) bio users
  final Set<String> unfavoritedBioUsers; // Track unfavorited (disliked) bio users
  final Map<String, int> likesCountAdjustment; // Track likes count changes per bioUser
  final Map<String, int> dislikesCountAdjustment; // Track dislikes count changes per bioUser

  FavoriteToggleState({
    this.isLoading = false,
    this.errorMessage,
    Set<String>? favoritedBioUsers,
    Set<String>? unfavoritedBioUsers,
    Map<String, int>? likesCountAdjustment,
    Map<String, int>? dislikesCountAdjustment,
  }) : favoritedBioUsers = favoritedBioUsers ?? {},
       unfavoritedBioUsers = unfavoritedBioUsers ?? {},
       likesCountAdjustment = likesCountAdjustment ?? {},
       dislikesCountAdjustment = dislikesCountAdjustment ?? {};

  FavoriteToggleState copyWith({
    bool? isLoading,
    String? errorMessage,
    Set<String>? favoritedBioUsers,
    Set<String>? unfavoritedBioUsers,
    Map<String, int>? likesCountAdjustment,
    Map<String, int>? dislikesCountAdjustment,
  }) {
    return FavoriteToggleState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      favoritedBioUsers: favoritedBioUsers ?? this.favoritedBioUsers,
      unfavoritedBioUsers: unfavoritedBioUsers ?? this.unfavoritedBioUsers,
      likesCountAdjustment: likesCountAdjustment ?? this.likesCountAdjustment,
      dislikesCountAdjustment: dislikesCountAdjustment ?? this.dislikesCountAdjustment,
    );
  }

  // Check status: 'favorited', 'unfavorited', or null (neutral)
  String? getStatus(String bioUser) {
    if (favoritedBioUsers.contains(bioUser)) return 'favorited';
    if (unfavoritedBioUsers.contains(bioUser)) return 'unfavorited';
    return null;
  }

  // Get adjusted likes count
  int getAdjustedLikesCount(String bioUser, int originalCount) {
    return originalCount + (likesCountAdjustment[bioUser] ?? 0);
  }

  // Get adjusted dislikes count
  int getAdjustedDislikesCount(String bioUser, int originalCount) {
    return originalCount + (dislikesCountAdjustment[bioUser] ?? 0);
  }
}

// Favorite Toggle Notifier
class FavoriteToggleNotifier extends StateNotifier<FavoriteToggleState> {
  final FavoritesRemoteDataSource _dataSource;

  FavoriteToggleNotifier(this._dataSource) : super(FavoriteToggleState());

  // Initialize with existing favorites and unfavorites
  void initializeFavorites(List<String> favoritedBioUsers, List<String> unfavoritedBioUsers) {
    state = state.copyWith(
      favoritedBioUsers: favoritedBioUsers.toSet(),
      unfavoritedBioUsers: unfavoritedBioUsers.toSet(),
    );
  }

  // Add to favorites (like)
  Future<bool> addFavorite(String bioUser) async {
    // Check if already was unfavorited (need to decrement dislikes)
    final wasUnfavorited = state.unfavoritedBioUsers.contains(bioUser);
    
    // Remove from unfavorited if exists (can't be both)
    final updatedUnfavorited = Set<String>.from(state.unfavoritedBioUsers)..remove(bioUser);
    final updatedFavorited = Set<String>.from(state.favoritedBioUsers)..add(bioUser);
    
    // Update count adjustments
    final updatedLikesAdjustment = Map<String, int>.from(state.likesCountAdjustment);
    final updatedDislikesAdjustment = Map<String, int>.from(state.dislikesCountAdjustment);
    
    updatedLikesAdjustment[bioUser] = (updatedLikesAdjustment[bioUser] ?? 0) + 1;
    if (wasUnfavorited) {
      updatedDislikesAdjustment[bioUser] = (updatedDislikesAdjustment[bioUser] ?? 0) - 1;
    }
    
    state = state.copyWith(
      favoritedBioUsers: updatedFavorited,
      unfavoritedBioUsers: updatedUnfavorited,
      likesCountAdjustment: updatedLikesAdjustment,
      dislikesCountAdjustment: updatedDislikesAdjustment,
    );

    try {
      final success = await _dataSource.addFavorite(bioUser);
      if (!success) {
        // Revert
        final revertedFavorited = Set<String>.from(state.favoritedBioUsers)..remove(bioUser);
        final revertedLikesAdjustment = Map<String, int>.from(state.likesCountAdjustment);
        revertedLikesAdjustment[bioUser] = (revertedLikesAdjustment[bioUser] ?? 0) - 1;
        state = state.copyWith(
          favoritedBioUsers: revertedFavorited,
          likesCountAdjustment: revertedLikesAdjustment,
          errorMessage: 'Failed to add favorite',
        );
        return false;
      }
      return true;
    } catch (e) {
      // Revert
      final revertedFavorited = Set<String>.from(state.favoritedBioUsers)..remove(bioUser);
      final revertedLikesAdjustment = Map<String, int>.from(state.likesCountAdjustment);
      revertedLikesAdjustment[bioUser] = (revertedLikesAdjustment[bioUser] ?? 0) - 1;
      state = state.copyWith(
        favoritedBioUsers: revertedFavorited,
        likesCountAdjustment: revertedLikesAdjustment,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  // Add to unfavorites (dislike)
  Future<bool> addUnfavorite(String bioUser) async {
    // Check if already was favorited (need to decrement likes)
    final wasFavorited = state.favoritedBioUsers.contains(bioUser);
    
    // Remove from favorited if exists (can't be both)
    final updatedFavorited = Set<String>.from(state.favoritedBioUsers)..remove(bioUser);
    final updatedUnfavorited = Set<String>.from(state.unfavoritedBioUsers)..add(bioUser);
    
    // Update count adjustments
    final updatedLikesAdjustment = Map<String, int>.from(state.likesCountAdjustment);
    final updatedDislikesAdjustment = Map<String, int>.from(state.dislikesCountAdjustment);
    
    updatedDislikesAdjustment[bioUser] = (updatedDislikesAdjustment[bioUser] ?? 0) + 1;
    if (wasFavorited) {
      updatedLikesAdjustment[bioUser] = (updatedLikesAdjustment[bioUser] ?? 0) - 1;
    }
    
    state = state.copyWith(
      favoritedBioUsers: updatedFavorited,
      unfavoritedBioUsers: updatedUnfavorited,
      likesCountAdjustment: updatedLikesAdjustment,
      dislikesCountAdjustment: updatedDislikesAdjustment,
    );

    try {
      final success = await _dataSource.removeFavorite(bioUser);
      if (!success) {
        // Revert
        final revertedUnfavorited = Set<String>.from(state.unfavoritedBioUsers)..remove(bioUser);
        final revertedDislikesAdjustment = Map<String, int>.from(state.dislikesCountAdjustment);
        revertedDislikesAdjustment[bioUser] = (revertedDislikesAdjustment[bioUser] ?? 0) - 1;
        state = state.copyWith(
          unfavoritedBioUsers: revertedUnfavorited,
          dislikesCountAdjustment: revertedDislikesAdjustment,
          errorMessage: 'Failed to add unfavorite',
        );
        return false;
      }
      return true;
    } catch (e) {
      // Revert
      final revertedUnfavorited = Set<String>.from(state.unfavoritedBioUsers)..remove(bioUser);
      final revertedDislikesAdjustment = Map<String, int>.from(state.dislikesCountAdjustment);
      revertedDislikesAdjustment[bioUser] = (revertedDislikesAdjustment[bioUser] ?? 0) - 1;
      state = state.copyWith(
        unfavoritedBioUsers: revertedUnfavorited,
        dislikesCountAdjustment: revertedDislikesAdjustment,
        errorMessage: e.toString(),
      );
      return false;
    }
  }
}

// Favorite Toggle Provider
final favoriteToggleProvider = StateNotifierProvider<FavoriteToggleNotifier, FavoriteToggleState>((ref) {
  final dataSource = ref.watch(favoritesRemoteDataSourceProvider);
  final notifier = FavoriteToggleNotifier(dataSource);
  
  // Initialize with existing favorites and unfavorites
  ref.listen(favoritesProvider, (previous, next) {
    next.whenData((favorites) {
      final favoritedBioUsers = favorites.map((f) => f.bioUser).toList();
      // Also get unfavorites
      ref.read(unfavoritesProvider).whenData((unfavorites) {
        final unfavoritedBioUsers = unfavorites.map((u) => u.bioUser).toList();
        notifier.initializeFavorites(favoritedBioUsers, unfavoritedBioUsers);
      });
    });
  });
  
  return notifier;
});