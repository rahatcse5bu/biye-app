class OngikarNamaEditModel {
  final String? id;
  final String? userId;
  final String isFamilyKnow;
  final String isTrueData;
  final String isAgree;

  OngikarNamaEditModel({
    this.id,
    this.userId,
    required this.isFamilyKnow,
    required this.isTrueData,
    required this.isAgree,
  });

  factory OngikarNamaEditModel.fromJson(Map<String, dynamic> json) {
    return OngikarNamaEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      isFamilyKnow: json['is_family_know']?.toString() ?? '',
      isTrueData: json['isTrueData']?.toString() ?? '',
      isAgree: json['isAgree']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'is_family_know': isFamilyKnow,
      'isTrueData': isTrueData,
      'isAgree': isAgree,
    };
  }

  static OngikarNamaEditModel empty() {
    return OngikarNamaEditModel(
      isFamilyKnow: '',
      isTrueData: '',
      isAgree: '',
    );
  }
}
