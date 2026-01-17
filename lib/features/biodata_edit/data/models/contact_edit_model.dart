class ContactEditModel {
  final String? id;
  final String? userId;
  final String fullName;
  final String familyNumber;
  final String relation;
  final String bioReceivingEmail;

  ContactEditModel({
    this.id,
    this.userId,
    required this.fullName,
    required this.familyNumber,
    required this.relation,
    required this.bioReceivingEmail,
  });

  factory ContactEditModel.fromJson(Map<String, dynamic> json) {
    return ContactEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      fullName: json['full_name']?.toString() ?? '',
      familyNumber: json['family_number']?.toString() ?? '',
      relation: json['relation']?.toString() ?? '',
      bioReceivingEmail: json['bio_receiving_email']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'user_form': 8, // Step 8 - Contact
      'full_name': fullName,
      'family_number': familyNumber,
      'relation': relation,
      'bio_receiving_email': bioReceivingEmail,
    };
  }

  static ContactEditModel empty() {
    return ContactEditModel(
      fullName: '',
      familyNumber: '',
      relation: '',
      bioReceivingEmail: '',
    );
  }
}
