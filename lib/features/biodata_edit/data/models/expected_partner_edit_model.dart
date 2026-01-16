class ExpectedPartnerEditModel {
  final String? id;
  final String? userId;
  final int minAge;
  final int maxAge;
  final List<String> color;
  final double minHeight;
  final double maxHeight;
  final List<String> educationalQualifications;
  final List<String> zilla;
  final List<String> maritalStatus;
  final List<String> occupation;
  final List<String> economicalCondition;
  final String? expectedCharacteristics;
  final String? aqidahMadhab;
  final String? isDivorcedWidow;
  final String? isChild;
  final String? isMasna;
  final String? isStudent;
  final double? expectedIncome;

  ExpectedPartnerEditModel({
    this.id,
    this.userId,
    this.minAge = 18,
    this.maxAge = 40,
    this.color = const [],
    this.minHeight = 4.5,
    this.maxHeight = 7.0,
    this.educationalQualifications = const [],
    this.zilla = const [],
    this.maritalStatus = const [],
    this.occupation = const [],
    this.economicalCondition = const [],
    this.expectedCharacteristics,
    this.aqidahMadhab,
    this.isDivorcedWidow,
    this.isChild,
    this.isMasna,
    this.isStudent,
    this.expectedIncome,
  });

  factory ExpectedPartnerEditModel.fromJson(Map<String, dynamic> json) {
    return ExpectedPartnerEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      minAge: json['age']?['min'] ?? 18,
      maxAge: json['age']?['max'] ?? 40,
      color: json['color'] != null
          ? List<String>.from(json['color'].map((x) => x.toString()))
          : [],
      minHeight: _toDouble(json['height']?['min'] ?? 4.5),
      maxHeight: _toDouble(json['height']?['max'] ?? 7.0),
      educationalQualifications: json['educational_qualifications'] != null
          ? List<String>.from(json['educational_qualifications'].map((x) => x.toString()))
          : [],
      zilla: json['zilla'] != null
          ? List<String>.from(json['zilla'].map((x) => x.toString()))
          : [],
      maritalStatus: json['marital_status'] != null
          ? List<String>.from(json['marital_status'].map((x) => x.toString()))
          : [],
      occupation: json['occupation'] != null
          ? List<String>.from(json['occupation'].map((x) => x.toString()))
          : [],
      economicalCondition: json['economical_condition'] != null
          ? List<String>.from(json['economical_condition'].map((x) => x.toString()))
          : [],
      expectedCharacteristics: json['expected_characteristics']?.toString(),
      aqidahMadhab: json['aqidah_madhab']?.toString(),
      isDivorcedWidow: json['isDivorced_Widow']?.toString(),
      isChild: json['isChild']?.toString(),
      isMasna: json['isMasna']?.toString(),
      isStudent: json['isStudent']?.toString(),
      expectedIncome: _toDoubleNullable(json['expected_income']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'age': {'min': minAge, 'max': maxAge},
      'color': color,
      'height': {'min': minHeight, 'max': maxHeight},
      'educational_qualifications': educationalQualifications,
      'zilla': zilla,
      'marital_status': maritalStatus,
      'occupation': occupation,
      'economical_condition': economicalCondition,
      if (expectedCharacteristics != null) 'expected_characteristics': expectedCharacteristics,
      if (aqidahMadhab != null) 'aqidah_madhab': aqidahMadhab,
      if (isDivorcedWidow != null) 'isDivorced_Widow': isDivorcedWidow,
      if (isChild != null) 'isChild': isChild,
      if (isMasna != null) 'isMasna': isMasna,
      if (isStudent != null) 'isStudent': isStudent,
      if (expectedIncome != null) 'expected_income': expectedIncome,
    };
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static double? _toDoubleNullable(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  static ExpectedPartnerEditModel empty() {
    return ExpectedPartnerEditModel();
  }
}
