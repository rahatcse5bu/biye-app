class GeneralInfoEditModel {
  final String? id;
  final String? userId;
  final String bioType;
  final bool isMarriageDone;
  final DateTime dateOfBirth;
  final double height;
  final String gender;
  final double weight;
  final String bloodGroup;
  final String screenColor;
  final String nationality;
  final String maritalStatus;
  final String? zilla;
  final String? religion; // islam, hinduism, christianity
  final String? religiousType; // practicing_muslim, general_muslim, practicing_hindu, general_hindu, practicing_christian, general_christian
  final bool? requestPracticingStatus; // User requests to be marked as practicing

  GeneralInfoEditModel({
    this.id,
    this.userId,
    required this.bioType,
    required this.isMarriageDone,
    required this.dateOfBirth,
    required this.height,
    required this.gender,
    required this.weight,
    required this.bloodGroup,
    required this.screenColor,
    required this.nationality,
    required this.maritalStatus,
    this.zilla,
    this.religion,
    this.religiousType,
    this.requestPracticingStatus,
  });

  factory GeneralInfoEditModel.fromJson(Map<String, dynamic> json) {
    return GeneralInfoEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      bioType: json['bio_type']?.toString() ?? '',
      isMarriageDone: json['isMarriageDone'] == true,
      dateOfBirth: json['date_of_birth'] != null
          ? DateTime.parse(json['date_of_birth'])
          : DateTime.now(),
      height: _toDouble(json['height']),
      gender: json['gender']?.toString() ?? '',
      weight: _toDouble(json['weight']),
      bloodGroup: json['blood_group']?.toString() ?? '',
      screenColor: json['screen_color']?.toString() ?? '',
      nationality: json['nationality']?.toString() ?? '',
      maritalStatus: json['marital_status']?.toString() ?? '',
      zilla: json['zilla']?.toString(),
      religion: json['religion']?.toString(),
      religiousType: json['religious_type']?.toString(),
      requestPracticingStatus: json['request_practicing_status'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'user_form': 0, // Step 0 - General Info
      'bio_type': bioType,
      'isMarriageDone': isMarriageDone,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'height': height,
      'gender': gender,
      'weight': weight,
      'blood_group': bloodGroup,
      'screen_color': screenColor,
      'nationality': nationality,
      'marital_status': maritalStatus,
      if (zilla != null) 'zilla': zilla,
      if (religion != null) 'religion': religion,
      if (religiousType != null) 'religious_type': religiousType,
      if (requestPracticingStatus != null) 'request_practicing_status': requestPracticingStatus,
    };
  }

  GeneralInfoEditModel copyWith({
    String? id,
    String? userId,
    String? bioType,
    bool? isMarriageDone,
    DateTime? dateOfBirth,
    double? height,
    String? gender,
    double? weight,
    String? bloodGroup,
    String? screenColor,
    String? nationality,
    String? maritalStatus,
    String? zilla,
    String? religion,
    String? religiousType,
    bool? requestPracticingStatus,
  }) {
    return GeneralInfoEditModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      bioType: bioType ?? this.bioType,
      isMarriageDone: isMarriageDone ?? this.isMarriageDone,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      weight: weight ?? this.weight,
      bloodGroup: bloodGroup ?? this.bloodGroup,
      screenColor: screenColor ?? this.screenColor,
      nationality: nationality ?? this.nationality,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      zilla: zilla ?? this.zilla,
      religion: religion ?? this.religion,
      religiousType: religiousType ?? this.religiousType,
      requestPracticingStatus: requestPracticingStatus ?? this.requestPracticingStatus,
    );
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  static GeneralInfoEditModel empty() {
    return GeneralInfoEditModel(
      bioType: '',
      isMarriageDone: false,
      dateOfBirth: DateTime.now().subtract(const Duration(days: 365 * 18)),
      height: 5.0,
      gender: '',
      weight: 50.0,
      bloodGroup: '',
      screenColor: '',
      nationality: 'বাংলাদেশী',
      maritalStatus: '',
      religion: 'islam', // Default to Islam
      religiousType: null,
      requestPracticingStatus: false,
    );
  }
}
