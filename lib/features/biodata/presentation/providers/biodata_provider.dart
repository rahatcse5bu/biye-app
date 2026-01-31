import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../../../core/providers/network_provider.dart';
import '../../data/datasources/biodata_remote_datasource.dart';
import '../../data/repositories/biodata_repository_impl.dart';
import '../../domain/repositories/biodata_repository.dart';
import '../../domain/usecases/get_biodata_by_id_usecase.dart';
import '../../domain/usecases/get_biodatas_usecase.dart';
import 'biodata_state.dart';

// Data Sources
final biodataRemoteDataSourceProvider = Provider<BiodataRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BiodataRemoteDataSourceImpl(dioClient);
});

// Repository
final biodataRepositoryProvider = Provider<BiodataRepository>((ref) {
  final remoteDataSource = ref.watch(biodataRemoteDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  
  return BiodataRepositoryImpl(
    remoteDataSource: remoteDataSource,
    networkInfo: networkInfo,
  );
});

// Use Cases
final getBiodatasUseCaseProvider = Provider<GetBiodatasUseCase>((ref) {
  final repository = ref.watch(biodataRepositoryProvider);
  return GetBiodatasUseCase(repository);
});

final getBiodataByIdUseCaseProvider = Provider<GetBiodataByIdUseCase>((ref) {
  final repository = ref.watch(biodataRepositoryProvider);
  return GetBiodataByIdUseCase(repository);
});

// Biodata List Notifier
class BiodataListNotifier extends StateNotifier<BiodataState> {
  final GetBiodatasUseCase getBiodatasUseCase;
  
  BiodataListNotifier(this.getBiodatasUseCase) : super(const BiodataState.initial());
  
  Future<void> loadBiodatas({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    state = const BiodataState.loading();
    
    final result = await getBiodatasUseCase(
      GetBiodatasParams(page: page, limit: limit, filters: filters),
    );
    
    result.fold(
      (failure) => state = BiodataState.error(failure.message),
      (biodatas) => state = BiodataState.loaded(biodatas),
    );
  }
  
  void reset() {
    state = const BiodataState.initial();
  }
}

// Biodata Detail Notifier
class BiodataDetailNotifier extends StateNotifier<BiodataDetailState> {
  final GetBiodataByIdUseCase getBiodataByIdUseCase;
  
  BiodataDetailNotifier(this.getBiodataByIdUseCase) 
      : super(const BiodataDetailState.initial());
  
  Future<void> loadBiodata(String id) async {
    state = const BiodataDetailState.loading();
    
    try {
      final result = await getBiodataByIdUseCase(id);
      
      result.fold(
        (failure) {
          print('Biodata load error: ${failure.message}');
          state = BiodataDetailState.error(failure.message);
        },
        (biodata) {
          print('Biodata loaded successfully: ${biodata.id}');
          state = BiodataDetailState.loaded(biodata);
        },
      );
    } catch (e, stackTrace) {
      print('Unexpected error loading biodata: $e');
      print('Stack trace: $stackTrace');
      state = BiodataDetailState.error('Error: $e');
    }
  }
  
  void reset() {
    state = const BiodataDetailState.initial();
  }
}

// State Notifier Providers
final biodataListNotifierProvider = 
    StateNotifierProvider<BiodataListNotifier, BiodataState>((ref) {
  final useCase = ref.watch(getBiodatasUseCaseProvider);
  return BiodataListNotifier(useCase);
});

final biodataDetailNotifierProvider = 
    StateNotifierProvider.autoDispose.family<BiodataDetailNotifier, BiodataDetailState, String>((ref, biodataId) {
  final useCase = ref.watch(getBiodataByIdUseCaseProvider);
  final notifier = BiodataDetailNotifier(useCase);
  // Load biodata automatically when provider is created
  Future.microtask(() => notifier.loadBiodata(biodataId));
  return notifier;
});
