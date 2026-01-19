import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/bkash_datasource.dart';

/// Provider for BkashDataSource
final bkashDataSourceProvider = Provider<BkashDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BkashDataSource(dioClient);
});

/// State for payment processing
class PaymentState {
  final bool isLoading;
  final String? error;
  final String? bkashURL;
  final String? paymentID;
  final bool paymentSuccess;
  final String? transactionId;
  final double? pointsAdded;

  const PaymentState({
    this.isLoading = false,
    this.error,
    this.bkashURL,
    this.paymentID,
    this.paymentSuccess = false,
    this.transactionId,
    this.pointsAdded,
  });

  PaymentState copyWith({
    bool? isLoading,
    String? error,
    String? bkashURL,
    String? paymentID,
    bool? paymentSuccess,
    String? transactionId,
    double? pointsAdded,
  }) {
    return PaymentState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      bkashURL: bkashURL ?? this.bkashURL,
      paymentID: paymentID ?? this.paymentID,
      paymentSuccess: paymentSuccess ?? this.paymentSuccess,
      transactionId: transactionId ?? this.transactionId,
      pointsAdded: pointsAdded ?? this.pointsAdded,
    );
  }
}

/// Notifier for handling bKash payments
class BkashPaymentNotifier extends StateNotifier<PaymentState> {
  final BkashDataSource _bkashDataSource;

  BkashPaymentNotifier(this._bkashDataSource) : super(const PaymentState());

  /// Create payment and get bKash URL
  Future<String?> createPayment({
    required int amount,
    required String callbackURL,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _bkashDataSource.createPayment(
        amount: amount,
        callbackURL: callbackURL,
      );
      final bkashURL = response['bkashURL'] as String?;
      final paymentID = response['paymentID'] as String?;
      state = state.copyWith(isLoading: false, bkashURL: bkashURL, paymentID: paymentID);
      return bkashURL;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  /// Process payment after bKash callback
  Future<bool> processAfterPay({
    required String paymentID,
    required String email,
    String purpose = 'buy_package',
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final response = await _bkashDataSource.afterPay(
        paymentID: paymentID,
        email: email,
        purpose: purpose,
      );
      
      final success = response['success'] == true;
      if (success) {
        final amount = response['amount'];
        double? points;
        if (amount != null) {
          // Handle both String and num types from API
          if (amount is num) {
            points = amount.toDouble() * 1.2;
          } else if (amount is String) {
            final parsedAmount = double.tryParse(amount);
            points = parsedAmount != null ? parsedAmount * 1.2 : null;
          }
        }
        state = state.copyWith(
          isLoading: false,
          paymentSuccess: true,
          transactionId: response['trxID'] as String?,
          pointsAdded: points,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: response['message'] as String? ?? 'Payment failed',
        );
      }
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
      return false;
    }
  }

  /// Reset state
  void reset() {
    state = const PaymentState();
  }
}

/// Provider for bKash payment notifier
final bkashPaymentNotifierProvider =
    StateNotifierProvider<BkashPaymentNotifier, PaymentState>((ref) {
  final dataSource = ref.watch(bkashDataSourceProvider);
  return BkashPaymentNotifier(dataSource);
});
