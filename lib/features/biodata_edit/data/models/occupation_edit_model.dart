class OccupationEditModel {
  final String? id;
  final String? userId;
  final List<String> occupation;
  final String occupationDetails;
  final double monthlyIncome;

  OccupationEditModel({
    this.id,
    this.userId,
    this.occupation = const [],
    required this.occupationDetails,
    required this.monthlyIncome,
  });

  factory OccupationEditModel.fromJson(Map<String, dynamic> json) {
    return OccupationEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      occupation: json['occupation'] != null
          ? List<String>.from(json['occupation'].map((x) => x.toString()))
          : [],
      occupationDetails: json['occupation_details']?.toString() ?? '',
      monthlyIncome: _toDouble(json['monthly_income']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'occupation': occupation,
      'occupation_details': occupationDetails,
      'monthly_income': monthlyIncome,
    };
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static OccupationEditModel empty() {
    return OccupationEditModel(
      occupationDetails: '',
      monthlyIncome: 0.0,
    );
  }
}
