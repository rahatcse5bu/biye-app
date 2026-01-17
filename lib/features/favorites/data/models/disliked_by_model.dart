class DislikedByModel {
  final String id;
  final String bioId;
  final String bioUser;
  final String permanentAddress;
  final String dateOfBirth;
  final String screenColor;

  DislikedByModel({
    required this.id,
    required this.bioId,
    required this.bioUser,
    required this.permanentAddress,
    required this.dateOfBirth,
    required this.screenColor,
  });

  factory DislikedByModel.fromJson(Map<String, dynamic> json) {
    return DislikedByModel(
      id: json['_id'] ?? '',
      bioId: json['bio_id'] ?? '',
      bioUser: json['bio_user'] ?? '',
      permanentAddress: json['permanent_address'] ?? '',
      dateOfBirth: json['date_of_birth'] ?? '',
      screenColor: json['screen_color'] ?? '',
    );
  }

  // Calculate age from date of birth
  int get ageFromDOB {
    if (dateOfBirth.isEmpty) return 0;
    try {
      final dob = DateTime.parse(dateOfBirth);
      final now = DateTime.now();
      int age = now.year - dob.year;
      if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
        age--;
      }
      return age;
    } catch (e) {
      return 0;
    }
  }

  // Format date of birth as DD-MM-YYYY
  String get formattedDOB {
    if (dateOfBirth.isEmpty) return '';
    try {
      final dob = DateTime.parse(dateOfBirth);
      return '${dob.day.toString().padLeft(2, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.year}';
    } catch (e) {
      return dateOfBirth;
    }
  }
}
