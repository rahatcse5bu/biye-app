import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/bkash_datasource.dart';
import '../../data/models/payment_history.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import 'bkash_provider.dart';

/// Provider for payment history list
final paymentHistoryProvider = FutureProvider.autoDispose<List<PaymentHistory>>((ref) async {
  final dataSource = ref.watch(bkashDataSourceProvider);
  
  // Ensure user is authenticated
  final authState = ref.watch(authNotifierProvider);
  authState.maybeWhen(
    authenticated: (_) {},
    orElse: () => throw Exception('User not authenticated'),
  );
  
  return await dataSource.getPaymentHistory();
});

/// State for refund request
class RefundRequestState {
  final bool isLoading;
  final String? error;
  final bool success;

  const RefundRequestState({
    this.isLoading = false,
    this.error,
    this.success = false,
  });

  RefundRequestState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return RefundRequestState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      success: success ?? this.success,
    );
  }
}

/// Notifier for handling refund requests
class RefundRequestNotifier extends StateNotifier<RefundRequestState> {
  final BkashDataSource _dataSource;

  RefundRequestNotifier(this._dataSource) : super(const RefundRequestState());

  Future<bool> requestRefund({
    required String paymentId,
    required String transactionId,
    required int amount,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      await _dataSource.requestRefund(
        paymentId: paymentId,
        transactionId: transactionId,
        amount: amount,
      );
      state = state.copyWith(isLoading: false, success: true);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  void reset() {
    state = const RefundRequestState();
  }
}

/// Provider for refund request notifier
final refundRequestNotifierProvider =
    StateNotifierProvider<RefundRequestNotifier, RefundRequestState>((ref) {
  final dataSource = ref.watch(bkashDataSourceProvider);
  return RefundRequestNotifier(dataSource);
});
