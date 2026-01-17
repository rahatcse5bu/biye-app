import 'package:flutter/material.dart';

class PurchaseFirstStepModel {
  final String permanentArea;
  final String presentArea;
  final String zilla;
  final int bioId;
  final String upzilla;
  final String division;
  final String city;
  final String status;
  final String? feedback;
  final String bioDetails;
  final String bioUser;

  PurchaseFirstStepModel({
    required this.permanentArea,
    required this.presentArea,
    required this.zilla,
    required this.bioId,
    required this.upzilla,
    required this.division,
    required this.city,
    required this.status,
    this.feedback,
    required this.bioDetails,
    required this.bioUser,
  });

  factory PurchaseFirstStepModel.fromJson(Map<String, dynamic> json) {
    return PurchaseFirstStepModel(
      permanentArea: json['permanent_area']?.toString() ?? '',
      presentArea: json['present_area']?.toString() ?? '',
      zilla: json['zilla']?.toString() ?? '',
      bioId: json['bio_id'] ?? 0,
      upzilla: json['upzilla']?.toString() ?? '',
      division: json['division']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      feedback: json['feedback']?.toString(),
      bioDetails: json['bio_details']?.toString() ?? '',
      bioUser: json['bio_user']?.toString() ?? '',
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
