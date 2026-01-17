import 'package:flutter/material.dart';

class BioShareModel {
  final String id;
  final String bioDetails;
  final String status;
  final String? feedback;
  final int userId;
  final String user;
  final String dateOfBirth;
  final String presentAddress;
  final String city;
  final String presentArea;

  BioShareModel({
    required this.id,
    required this.bioDetails,
    required this.status,
    this.feedback,
    required this.userId,
    required this.user,
    required this.dateOfBirth,
    required this.presentAddress,
    required this.city,
    required this.presentArea,
  });

  factory BioShareModel.fromJson(Map<String, dynamic> json) {
    return BioShareModel(
      id: json['_id']?.toString() ?? '',
      bioDetails: json['bio_details']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      feedback: json['feedback']?.toString(),
      userId: json['user_id'] ?? 0,
      user: json['user']?.toString() ?? '',
      dateOfBirth: json['date_of_birth']?.toString() ?? '',
      presentAddress: json['present_address']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      presentArea: json['present_area']?.toString() ?? '',
    );
  }

  String get statusBangla {
    switch (status.toLowerCase()) {
      case 'pending':
        return 'Pending';
      case 'rejected':
        return 'Rejected';
      case 'approved':
        return 'Approved';
      default:
        return status;
    }
  }

  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'rejected':
        return Colors.red;
      case 'approved':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
