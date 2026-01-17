class UnfavoriteModel {
  final String id;
  final int bioId;
  final String bioUser;
  final String permanentAddress;
  final String dateOfBirth;
  final String screenColor;

  UnfavoriteModel({
    required this.id,
    required this.bioId,
    required this.bioUser,
    required this.permanentAddress,
    required this.dateOfBirth,
    required this.screenColor,
  });

  factory UnfavoriteModel.fromJson(Map<String, dynamic> json) {
    return UnfavoriteModel(
      id: json['_id']?.toString() ?? '',
      bioId: json['bio_id'] ?? 0,
      bioUser: json['bio_user']?.toString() ?? '',
      permanentAddress: json['permanent_address']?.toString() ?? '',
      dateOfBirth: json['date_of_birth']?.toString() ?? '',
      screenColor: json['screen_color']?.toString() ?? '',
    );
  }

  String get ageFromDOB {
    try {
      final dob = DateTime.parse(dateOfBirth);
      final now = DateTime.now();
      int age = now.year - dob.year;
      if (now.month < dob.month || (now.month == dob.month && now.day < dob.day)) {
        age--;
      }
      return age.toString();
    } catch (e) {
      return 'N/A';
    }
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
