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
  final String? user;
  final String? bioUser;
  final ReactionType reactionType;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  // Additional fields from aggregated responses
  final int? bioId;
  final String? permanentAddress;
  final String? dateOfBirth;
  final String? screenColor;

  ReactionModel({
    this.id,
    this.user,
    this.bioUser,
    required this.reactionType,
    this.createdAt,
    this.updatedAt,
    this.bioId,
    this.permanentAddress,
    this.dateOfBirth,
    this.screenColor,
  });

  factory ReactionModel.fromJson(Map<String, dynamic> json) {
    // Handle ObjectId fields that might come as objects or strings
    String? parseId(dynamic value) {
      if (value == null) return null;
      if (value is String) return value;
      if (value is Map && value['\$oid'] != null) return value['\$oid'] as String;
      return value.toString();
    }
    
    return ReactionModel(
      id: parseId(json['_id']),
      user: parseId(json['user']),
      bioUser: parseId(json['bio_user']),
      reactionType: ReactionType.fromJson(json['reaction_type'] ?? 'like'),
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      bioId: json['bio_id'] is int ? json['bio_id'] : (json['bio_id'] != null ? int.tryParse(json['bio_id'].toString()) : null),
      permanentAddress: json['permanent_address']?.toString(),
      dateOfBirth: json['date_of_birth']?.toString(),
      screenColor: json['screen_color']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'bio_user': bioUser,
      'reaction_type': reactionType.toJson(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'bio_id': bioId,
      'permanent_address': permanentAddress,
      'date_of_birth': dateOfBirth,
      'screen_color': screenColor,
    };
  }

  ReactionModel copyWith({
    String? id,
    String? user,
    String? bioUser,
    ReactionType? reactionType,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? bioId,
    String? permanentAddress,
    String? dateOfBirth,
    String? screenColor,
  }) {
    return ReactionModel(
      id: id ?? this.id,
      user: user ?? this.user,
      bioUser: bioUser ?? this.bioUser,
      reactionType: reactionType ?? this.reactionType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      bioId: bioId ?? this.bioId,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      screenColor: screenColor ?? this.screenColor,
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
