class ContactPurchaseRequest {
  final String bioUser;

  ContactPurchaseRequest({
    required this.bioUser,
  });

  Map<String, dynamic> toJson() {
    return {
      'bio_user': bioUser,
    };
  }
}

class ContactPurchaseResponse {
  final bool success;
  final String message;

  ContactPurchaseResponse({
    required this.success,
    required this.message,
  });

  factory ContactPurchaseResponse.fromJson(Map<String, dynamic> json) {
    return ContactPurchaseResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }
}
