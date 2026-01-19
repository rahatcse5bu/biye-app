/// Payment history model
class PaymentHistory {
  final String id;
  final String email;
  final double points;
  final int amount;
  final String transactionId;
  final String paymentId;
  final String status;
  final String? purpose;
  final String? trnxTime;
  final String createdAt;
  final String updatedAt;
  final bool refundRequested;

  PaymentHistory({
    required this.id,
    required this.email,
    required this.points,
    required this.amount,
    required this.transactionId,
    required this.paymentId,
    required this.status,
    this.purpose,
    this.trnxTime,
    required this.createdAt,
    required this.updatedAt,
    this.refundRequested = false,
  });

  factory PaymentHistory.fromJson(Map<String, dynamic> json) {
    // Handle amount as either int or String from API
    int parseAmount(dynamic value) {
      if (value is int) return value;
      if (value is String) return int.tryParse(value) ?? 0;
      if (value is double) return value.toInt();
      return 0;
    }

    return PaymentHistory(
      id: json['id'] as String? ?? json['_id'] as String? ?? '',
      email: json['email'] as String? ?? '',
      points: (json['points'] as num?)?.toDouble() ?? 0.0,
      amount: parseAmount(json['amount']),
      transactionId: json['transaction_id'] as String? ?? '',
      paymentId: json['payment_id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      purpose: json['purpose'] as String?,
      trnxTime: json['trnx_time'] as String?,
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
      refundRequested: json['refund_requested'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'points': points,
      'amount': amount,
      'transaction_id': transactionId,
      'payment_id': paymentId,
      'status': status,
      'purpose': purpose,
      'trnx_time': trnxTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'refund_requested': refundRequested,
    };
  }
}
