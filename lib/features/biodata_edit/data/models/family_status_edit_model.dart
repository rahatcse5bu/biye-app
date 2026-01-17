class FamilyStatusEditModel {
  final String? id;
  final String? userId;
  final String fatherName;
  final String fatherOccupation;
  final String isFatherAlive;
  final String motherName;
  final String isMotherAlive;
  final String motherOccupation;
  final String? numberOfBrothers;
  final List<String> brotherInfo;
  final String? numberOfSisters;
  final List<String> sisterInfo;
  final String? uncleInfo;
  final String familyEcoCondition;
  final String ecoConditionType;
  final String familyDeeniInfo;

  FamilyStatusEditModel({
    this.id,
    this.userId,
    required this.fatherName,
    required this.fatherOccupation,
    required this.isFatherAlive,
    required this.motherName,
    required this.isMotherAlive,
    required this.motherOccupation,
    this.numberOfBrothers,
    this.brotherInfo = const [],
    this.numberOfSisters,
    this.sisterInfo = const [],
    this.uncleInfo,
    required this.familyEcoCondition,
    required this.ecoConditionType,
    required this.familyDeeniInfo,
  });

  factory FamilyStatusEditModel.fromJson(Map<String, dynamic> json) {
    return FamilyStatusEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      fatherName: json['father_name']?.toString() ?? '',
      fatherOccupation: json['father_occupation']?.toString() ?? '',
      isFatherAlive: json['isFatherAlive']?.toString() ?? '',
      motherName: json['mother_name']?.toString() ?? '',
      isMotherAlive: json['isMotherAlive']?.toString() ?? '',
      motherOccupation: json['mother_occupation']?.toString() ?? '',
      numberOfBrothers: json['number_of_brothers']?.toString(),
      brotherInfo: json['brother_info'] != null
          ? List<String>.from(json['brother_info'].map((x) => x.toString()))
          : [],
      numberOfSisters: json['number_of_sisters']?.toString(),
      sisterInfo: json['sister_info'] != null
          ? List<String>.from(json['sister_info'].map((x) => x.toString()))
          : [],
      uncleInfo: json['uncle_info']?.toString(),
      familyEcoCondition: json['family_eco_condition']?.toString() ?? '',
      ecoConditionType: json['eco_condition_type']?.toString() ?? '',
      familyDeeniInfo: json['family_deeni_info']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'user_form': 3, // Step 3 - Family Status
      'father_name': fatherName,
      'father_occupation': fatherOccupation,
      'isFatherAlive': isFatherAlive,
      'mother_name': motherName,
      'isMotherAlive': isMotherAlive,
      'mother_occupation': motherOccupation,
      if (numberOfBrothers != null) 'number_of_brothers': numberOfBrothers,
      'brother_info': brotherInfo,
      if (numberOfSisters != null) 'number_of_sisters': numberOfSisters,
      'sister_info': sisterInfo,
      if (uncleInfo != null) 'uncle_info': uncleInfo,
      'family_eco_condition': familyEcoCondition,
      'eco_condition_type': ecoConditionType,
      'family_deeni_info': familyDeeniInfo,
    };
  }

  static FamilyStatusEditModel empty() {
    return FamilyStatusEditModel(
      fatherName: '',
      fatherOccupation: '',
      isFatherAlive: '',
      motherName: '',
      isMotherAlive: '',
      motherOccupation: '',
      familyEcoCondition: '',
      ecoConditionType: '',
      familyDeeniInfo: '',
    );
  }
}
