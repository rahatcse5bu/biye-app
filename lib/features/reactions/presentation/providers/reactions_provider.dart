import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/reactions_remote_datasource.dart';
import '../../data/models/reaction_model.dart';

// Datasource Provider
final reactionsRemoteDataSourceProvider = Provider<ReactionsRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReactionsRemoteDataSource(dioClient);
});

// Toggle reaction provider
final toggleReactionProvider = FutureProvider.autoDispose.family<ReactionModel?, Map<String, dynamic>>((ref, params) async {
  final dataSource = ref.watch(reactionsRemoteDataSourceProvider);
  final bioUserId = params['bioUserId'] as String;
  final reactionType = params['reactionType'] as ReactionType;
  
  return await dataSource.toggleReaction(
    bioUserId: bioUserId,
    reactionType: reactionType,
  );
});

// Reaction counts provider
final reactionCountsProvider = FutureProvider.autoDispose.family<List<ReactionCountModel>, String>((ref, bioUserId) async {
  final dataSource = ref.watch(reactionsRemoteDataSourceProvider);
  return await dataSource.getReactionCounts(bioUserId);
});

// My reaction for specific bio provider
final myReactionForBioProvider = FutureProvider.autoDispose.family<ReactionModel?, String>((ref, bioUserId) async {
  final dataSource = ref.watch(reactionsRemoteDataSourceProvider);
  return await dataSource.getMyReactionForBio(bioUserId);
});

// My reactions list provider with optional filter
final myReactionsProvider = FutureProvider.autoDispose.family<List<ReactionModel>, ReactionType?>((ref, reactionType) async {
  final dataSource = ref.watch(reactionsRemoteDataSourceProvider);
  return await dataSource.getMyReactions(reactionType: reactionType);
});

// Reactions by type provider
final reactionsByTypeProvider = FutureProvider.autoDispose.family<List<ReactionModel>, ReactionType>((ref, reactionType) async {
  final dataSource = ref.watch(reactionsRemoteDataSourceProvider);
  return await dataSource.getReactionsByType(reactionType);
});

// Reactions received provider with optional filter
final reactionsReceivedProvider = FutureProvider.autoDispose.family<List<ReactionModel>, ReactionType?>((ref, reactionType) async {
  final dataSource = ref.watch(reactionsRemoteDataSourceProvider);
  return await dataSource.getReactionsReceived(reactionType: reactionType);
});

// State notifier for managing reaction state
class ReactionState {
  final ReactionModel? currentReaction;
  final List<ReactionCountModel> counts;
  final bool isLoading;
  final String? error;

  ReactionState({
    this.currentReaction,
    this.counts = const [],
    this.isLoading = false,
    this.error,
  });

  ReactionState copyWith({
    ReactionModel? Function()? currentReaction,
    List<ReactionCountModel>? counts,
    bool? isLoading,
    String? Function()? error,
  }) {
    return ReactionState(
      currentReaction: currentReaction != null ? currentReaction() : this.currentReaction,
      counts: counts ?? this.counts,
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error() : this.error,
    );
  }
}

class ReactionNotifier extends StateNotifier<ReactionState> {
  final ReactionsRemoteDataSource dataSource;
  final String bioUserId;

  ReactionNotifier(this.dataSource, this.bioUserId) : super(ReactionState()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true);
    try {
      final reaction = await dataSource.getMyReactionForBio(bioUserId);
      final counts = await dataSource.getReactionCounts(bioUserId);
      state = state.copyWith(
        currentReaction: () => reaction,
        counts: counts,
        isLoading: false,
        error: () => null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: () => e.toString(),
      );
    }
  }

  Future<void> toggleReaction(ReactionType reactionType) async {
    // Optimistic update
    final previousReaction = state.currentReaction;
    final previousCounts = state.counts;

    // If same reaction, remove it
    if (state.currentReaction?.reactionType == reactionType) {
      state = state.copyWith(
        currentReaction: () => null,
        counts: _decrementCount(state.counts, reactionType),
      );
    } else {
      // Otherwise, update to new reaction
      state = state.copyWith(
        currentReaction: () => ReactionModel(
          user: '',
          bioUser: bioUserId,
          reactionType: reactionType,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        counts: _updateCounts(state.counts, previousReaction?.reactionType, reactionType),
      );
    }

    try {
      final result = await dataSource.toggleReaction(
        bioUserId: bioUserId,
        reactionType: reactionType,
      );
      
      // Refresh counts
      final counts = await dataSource.getReactionCounts(bioUserId);
      state = state.copyWith(
        currentReaction: () => result,
        counts: counts,
        error: () => null,
      );
    } catch (e) {
      // Revert on error
      state = state.copyWith(
        currentReaction: () => previousReaction,
        counts: previousCounts,
        error: () => e.toString(),
      );
    }
  }

  List<ReactionCountModel> _updateCounts(
    List<ReactionCountModel> counts,
    ReactionType? oldType,
    ReactionType newType,
  ) {
    final updatedCounts = List<ReactionCountModel>.from(counts);
    
    // Decrement old type if exists
    if (oldType != null) {
      final oldIndex = updatedCounts.indexWhere((c) => c.reactionType == oldType);
      if (oldIndex != -1) {
        final oldCount = updatedCounts[oldIndex];
        if (oldCount.count > 1) {
          updatedCounts[oldIndex] = ReactionCountModel(
            reactionType: oldType,
            count: oldCount.count - 1,
          );
        } else {
          updatedCounts.removeAt(oldIndex);
        }
      }
    }
    
    // Increment new type
    final newIndex = updatedCounts.indexWhere((c) => c.reactionType == newType);
    if (newIndex != -1) {
      final newCount = updatedCounts[newIndex];
      updatedCounts[newIndex] = ReactionCountModel(
        reactionType: newType,
        count: newCount.count + 1,
      );
    } else {
      updatedCounts.add(ReactionCountModel(
        reactionType: newType,
        count: 1,
      ));
    }
    
    return updatedCounts;
  }

  List<ReactionCountModel> _decrementCount(
    List<ReactionCountModel> counts,
    ReactionType type,
  ) {
    final updatedCounts = List<ReactionCountModel>.from(counts);
    final index = updatedCounts.indexWhere((c) => c.reactionType == type);
    
    if (index != -1) {
      final count = updatedCounts[index];
      if (count.count > 1) {
        updatedCounts[index] = ReactionCountModel(
          reactionType: type,
          count: count.count - 1,
        );
      } else {
        updatedCounts.removeAt(index);
      }
    }
    
    return updatedCounts;
  }

  void refresh() {
    _loadInitialData();
  }
}

// Provider for reaction notifier
final reactionNotifierProvider = StateNotifierProvider.autoDispose.family<ReactionNotifier, ReactionState, String>((ref, bioUserId) {
  final dataSource = ref.watch(reactionsRemoteDataSourceProvider);
  return ReactionNotifier(dataSource, bioUserId);
});
