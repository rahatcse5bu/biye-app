import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../biodata/domain/entities/biodata_entity.dart';
import '../../../biodata/presentation/providers/biodata_provider.dart';

// Provider for biodata stats
final biodataStatsProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  final remoteDataSource = ref.watch(biodataRemoteDataSourceProvider);
  try {
    return await remoteDataSource.getBiodataStats();
  } catch (e) {
    // Return default stats if API fails
    return {
      'পুরুষ': 0,
      'মহিলা': 0,
      'completedMarriages': 0,
    };
  }
});

// Provider for featured biodatas
final featuredBiodataProvider = FutureProvider<List<BiodataEntity>>((ref) async {
  final remoteDataSource = ref.watch(biodataRemoteDataSourceProvider);
  try {
    final biodatas = await remoteDataSource.getBiodatas(
      isFeatured: true,
      limit: 10,
    );
    return biodatas.map((model) => model.toEntity()).toList();
  } catch (e) {
    return [];
  }
});
