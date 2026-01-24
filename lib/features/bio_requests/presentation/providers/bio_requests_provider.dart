import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/bio_requests_remote_datasource.dart';
import '../../data/models/bio_share_model.dart';

// Datasource Provider
final bioRequestsRemoteDataSourceProvider = Provider<BioRequestsRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BioRequestsRemoteDataSource(dioClient);
});

// Bio Requests Provider
final bioRequestsProvider = FutureProvider<List<BioShareModel>>((ref) async {
  final dataSource = ref.watch(bioRequestsRemoteDataSourceProvider);
  return await dataSource.getBioRequests();
});

// Update Bio Request Status Provider
final updateBioRequestStatusProvider = FutureProvider.family<bool, Map<String, dynamic>>((ref, params) async {
  final dataSource = ref.watch(bioRequestsRemoteDataSourceProvider);
  return await dataSource.updateBioRequestStatus(
    userId: params['userId'] as String,
    status: params['status'] as String,
    feedback: params['feedback'] as String?,
  );
});
