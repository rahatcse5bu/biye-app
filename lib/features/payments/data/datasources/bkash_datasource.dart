import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../models/payment_history.dart';

/// bKash payment data source for API calls
class BkashDataSource {
  final DioClient _dioClient;

  BkashDataSource(this._dioClient);

  /// Create bKash payment and get bKash URL for redirect
  /// Returns the bKashURL to open in WebView
  Future<Map<String, dynamic>> createPayment({
    required int amount,
    required String callbackURL,
  }) async {
    try {
      final response = await _dioClient.post(
        '/bkash/create',
        data: {
          'amount': amount,
          'callbackURL': callbackURL,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Payment creation failed');
    }
  }

  /// Execute bKash payment after user confirmation
  Future<Map<String, dynamic>> executePayment({
    required String paymentID,
  }) async {
    try {
      final response = await _dioClient.post(
        '/bkash/execute',
        data: {
          'paymentID': paymentID,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Payment execution failed');
    }
  }

  /// Query bKash payment status
  Future<Map<String, dynamic>> queryPayment({
    required String paymentID,
  }) async {
    try {
      final response = await _dioClient.post(
        '/bkash/query',
        data: {
          'paymentID': paymentID,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Payment query failed');
    }
  }

  /// Process payment after bKash callback (execute + add points)
  Future<Map<String, dynamic>> afterPay({
    required String paymentID,
    required String email,
    String purpose = 'buy_package',
  }) async {
    try {
      final response = await _dioClient.post(
        '/bkash/after-pay',
        data: {
          'paymentID': paymentID,
          'email': email,
          'purpose': purpose,
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'After pay processing failed');
    }
  }

  /// Get payment history for logged-in user
  Future<List<PaymentHistory>> getPaymentHistory() async {
    try {
      final response = await _dioClient.get('/payments/token');
      final data = response.data['data'] as List;
      return data.map((json) => PaymentHistory.fromJson(json)).toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Failed to load payment history');
    }
  }

  /// Request refund for a payment
  Future<Map<String, dynamic>> requestRefund({
    required String paymentId,
    required String transactionId,
    required int amount,
  }) async {
    try {
      final response = await _dioClient.post(
        '/refunds',
        data: {
          'payment_id': paymentId,
          'transaction_id': transactionId,
          'amount': amount,
          'refund_status': 'requested',
          'refund_req_time': DateTime.now().toIso8601String(),
        },
      );
      return response.data;
    } on DioException catch (e) {
      throw Exception(e.response?.data?['message'] ?? 'Refund request failed');
    }
  }
}
