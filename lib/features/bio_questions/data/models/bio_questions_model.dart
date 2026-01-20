class BioQuestionsModel {
  final String? id;
  final String user;
  final List<String> questions;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  BioQuestionsModel({
    this.id,
    required this.user,
    required this.questions,
    this.createdAt,
    this.updatedAt,
  });

  factory BioQuestionsModel.fromJson(Map<String, dynamic> json) {
    return BioQuestionsModel(
      id: json['_id'] as String?,
      user: json['user'] as String,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null 
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      'user': user,
      'questions': questions,
      if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
      if (updatedAt != null) 'updatedAt': updatedAt!.toIso8601String(),
    };
  }

  BioQuestionsModel copyWith({
    String? id,
    String? user,
    List<String>? questions,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BioQuestionsModel(
      id: id ?? this.id,
      user: user ?? this.user,
      questions: questions ?? this.questions,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
