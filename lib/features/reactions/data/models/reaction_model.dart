enum ReactionType {
  like,
  dislike,
  love,
  sad,
  angry,
  wow;

  String toJson() => name;
  
  static ReactionType fromJson(String value) {
    return values.firstWhere(
      (element) => element.name == value,
      orElse: () => ReactionType.like,
    );
  }
}

class ReactionModel {
  final String? id;
  final String user;
  final String bioUser;
  final ReactionType reactionType;
  final DateTime createdAt;
  final DateTime updatedAt;

  ReactionModel({
    this.id,
    required this.user,
    required this.bioUser,
    required this.reactionType,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    return ReactionModel(
      id: json['_id'],
      user: json['user'],
      bioUser: json['bio_user'],
      reactionType: ReactionType.fromJson(json['reaction_type']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'bio_user': bioUser,
      'reaction_type': reactionType.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ReactionModel copyWith({
    String? id,
    String? user,
    String? bioUser,
    ReactionType? reactionType,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ReactionModel(
      id: id ?? this.id,
      user: user ?? this.user,
      bioUser: bioUser ?? this.bioUser,
      reactionType: reactionType ?? this.reactionType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ReactionCountModel {
  final ReactionType reactionType;
  final int count;

  ReactionCountModel({
    required this.reactionType,
    required this.count,
  });

  factory ReactionCountModel.fromJson(Map<String, dynamic> json) {
    return ReactionCountModel(
      reactionType: ReactionType.fromJson(json['_id']),
      count: json['count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': reactionType.toJson(),
      'count': count,
    };
  }
}
