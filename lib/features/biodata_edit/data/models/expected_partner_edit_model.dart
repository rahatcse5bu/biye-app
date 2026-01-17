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
    final Map<String, dynamic> json = {
      'user_form': 7,
      'age': {
        'min': minAge,
        'max': maxAge,
      },
      'height': {
        'min': minHeight,
        'max': maxHeight,
      },
      'color': color.where((c) => c.trim().isNotEmpty).toList(),
      'educational_qualifications': educationalQualifications.where((e) => e.trim().isNotEmpty).toList(),
      'zilla': zilla.where((z) => z.trim().isNotEmpty).toList(),
      'marital_status': maritalStatus.where((m) => m.trim().isNotEmpty).toList(),
      'occupation': occupation.where((o) => o.trim().isNotEmpty).toList(),
      'economical_condition': economicalCondition.where((e) => e.trim().isNotEmpty).toList(),
    };
    
    if (id != null && id!.isNotEmpty) {
      json['_id'] = id;
    }
    if (userId != null && userId!.isNotEmpty) {
      json['user'] = userId;
    }
    if (expectedCharacteristics != null && expectedCharacteristics!.trim().isNotEmpty) {
      json['expected_characteristics'] = expectedCharacteristics!.trim();
    }
    if (aqidahMadhab != null && aqidahMadhab!.trim().isNotEmpty) {
      json['aqidah_madhab'] = aqidahMadhab!.trim();
    }
    if (isDivorcedWidow != null && isDivorcedWidow!.trim().isNotEmpty) {
      json['isDivorced_Widow'] = isDivorcedWidow!.trim();
    }
    if (isChild != null && isChild!.trim().isNotEmpty) {
      json['isChild'] = isChild!.trim();
    }
    if (isMasna != null && isMasna!.trim().isNotEmpty) {
      json['isMasna'] = isMasna!.trim();
    }
    if (isStudent != null && isStudent!.trim().isNotEmpty) {
      json['isStudent'] = isStudent!.trim();
    }
    if (expectedIncome != null) {
      json['expected_income'] = expectedIncome;
    }
    
    return json;
  }

  ExpectedPartnerEditModel copyWith({
    String? id,
    String? userId,
    int? minAge,
    int? maxAge,
    List<String>? color,
    double? minHeight,
    double? maxHeight,
    List<String>? educationalQualifications,
    List<String>? zilla,
    List<String>? maritalStatus,
    List<String>? occupation,
    List<String>? economicalCondition,
    String? expectedCharacteristics,
    String? aqidahMadhab,
    String? isDivorcedWidow,
    String? isChild,
    String? isMasna,
    String? isStudent,
    double? expectedIncome,
  }) {
    return ExpectedPartnerEditModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      minAge: minAge ?? this.minAge,
      maxAge: maxAge ?? this.maxAge,
      color: color ?? this.color,
      minHeight: minHeight ?? this.minHeight,
      maxHeight: maxHeight ?? this.maxHeight,
      educationalQualifications: educationalQualifications ?? this.educationalQualifications,
      zilla: zilla ?? this.zilla,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      occupation: occupation ?? this.occupation,
      economicalCondition: economicalCondition ?? this.economicalCondition,
      expectedCharacteristics: expectedCharacteristics ?? this.expectedCharacteristics,
      aqidahMadhab: aqidahMadhab ?? this.aqidahMadhab,
      isDivorcedWidow: isDivorcedWidow ?? this.isDivorcedWidow,
      isChild: isChild ?? this.isChild,
      isMasna: isMasna ?? this.isMasna,
      isStudent: isStudent ?? this.isStudent,
      expectedIncome: expectedIncome ?? this.expectedIncome,
    );
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
