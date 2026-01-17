import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/purchases_first_step_datasource.dart';
import '../../data/datasources/purchases_second_step_datasource.dart';
import '../../data/models/purchase_first_step_model.dart';
import '../../data/models/purchase_second_step_model.dart';

// First Step Datasource Provider
final purchasesFirstStepDataSourceProvider = Provider<PurchasesRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PurchasesRemoteDataSource(dioClient);
});

// Second Step Datasource Provider
final purchasesSecondStepDataSourceProvider = Provider<PurchasesSecondStepDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PurchasesSecondStepDataSource(dioClient);
});

// First Step Purchases Provider
final purchasesFirstStepProvider = FutureProvider<List<PurchaseFirstStepModel>>((ref) async {
  final dataSource = ref.watch(purchasesFirstStepDataSourceProvider);
  return await dataSource.getFirstStepPurchases();
});

// Second Step Purchases Provider
final purchasesSecondStepProvider = FutureProvider<List<PurchaseSecondStepModel>>((ref) async {
  final dataSource = ref.watch(purchasesSecondStepDataSourceProvider);
  return await dataSource.getSecondStepPurchases();
});
