class PurchaseSecondStepModel {
  final String permanentArea;
  final String presentArea;
  final String zilla;
  final int bioId;
  final String upzilla;
  final String division;
  final String fullName;
  final String familyNumber;
  final String relation;
  final String bioReceivingEmail;
  final String dateOfBirth;
  final String city;
  final String? status;
  final String? feedback;
  final String? bioDetails;
  final String bioUser;

  PurchaseSecondStepModel({
    required this.permanentArea,
    required this.presentArea,
    required this.zilla,
    required this.bioId,
    required this.upzilla,
    required this.division,
    required this.fullName,
    required this.familyNumber,
    required this.relation,
    required this.bioReceivingEmail,
    required this.dateOfBirth,
    required this.city,
    this.status,
    this.feedback,
    this.bioDetails,
    required this.bioUser,
  });

  factory PurchaseSecondStepModel.fromJson(Map<String, dynamic> json) {
    return PurchaseSecondStepModel(
      permanentArea: json['permanent_area']?.toString() ?? '',
      presentArea: json['present_area']?.toString() ?? '',
      zilla: json['zilla']?.toString() ?? '',
      bioId: json['bio_id'] ?? 0,
      upzilla: json['upzilla']?.toString() ?? '',
      division: json['division']?.toString() ?? '',
      fullName: json['full_name']?.toString() ?? '',
      familyNumber: json['family_number']?.toString() ?? '',
      relation: json['relation']?.toString() ?? '',
      bioReceivingEmail: json['bio_receiving_email']?.toString() ?? '',
      dateOfBirth: json['date_of_birth']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      status: json['status']?.toString(),
      feedback: json['feedback']?.toString(),
      bioDetails: json['bio_details']?.toString(),
      bioUser: json['bio_user']?.toString() ?? '',
    );
  }

  String get formattedDOB {
    try {
      final dob = DateTime.parse(dateOfBirth);
      return '${dob.day.toString().padLeft(2, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.year}';
    } catch (e) {
      return dateOfBirth;
    }
  }
}
