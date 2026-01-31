import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class Division {
  final String id;
  final String name;
  final String value;

  Division({required this.id, required this.name, required this.value});

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

class District {
  final String id;
  final String divisionId;
  final String label;
  final String value;

  District({
    required this.id,
    required this.divisionId,
    required this.label,
    required this.value,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id'] ?? '',
      divisionId: json['division_id'] ?? '',
      label: json['label'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

class Upazila {
  final String id;
  final String districtId;
  final String name;
  final String value;

  Upazila({
    required this.id,
    required this.districtId,
    required this.name,
    required this.value,
  });

  factory Upazila.fromJson(Map<String, dynamic> json) {
    return Upazila(
      id: json['id'] ?? '',
      districtId: json['district_id'] ?? '',
      name: json['name'] ?? '',
      value: json['value'] ?? '',
    );
  }
}

class AddressService {
  static AddressService? _instance;
  
  List<Division> _divisions = [];
  List<District> _districts = [];
  List<Upazila> _upazilas = [];
  
  bool _isLoaded = false;
  
  AddressService._();
  
  static AddressService get instance {
    _instance ??= AddressService._();
    return _instance!;
  }
  
  Future<void> loadData() async {
    if (_isLoaded) return;
    
    try {
      // Load divisions
      final divisionsJson = await rootBundle.loadString('assets/data/divisions.json');
      final divisionsList = json.decode(divisionsJson) as List;
      _divisions = divisionsList.map((d) => Division.fromJson(d)).toList();
      
      // Load districts
      final districtsJson = await rootBundle.loadString('assets/data/districts.json');
      final districtsList = json.decode(districtsJson) as List;
      _districts = districtsList.map((d) => District.fromJson(d)).toList();
      
      // Load upazilas
      final upazilasJson = await rootBundle.loadString('assets/data/upzila.json');
      final upazilasList = json.decode(upazilasJson) as List;
      _upazilas = upazilasList.map((u) => Upazila.fromJson(u)).toList();
      
      _isLoaded = true;
    } catch (e) {
      debugPrint('Error loading address data: $e');
    }
  }
  
  List<String> getDivisions() {
    return _divisions.map((d) => d.value).toList();
  }
  
  List<String> getDistrictsByDivision(String divisionValue) {
    // Find the division ID by value
    final division = _divisions.firstWhere(
      (d) => d.value == divisionValue,
      orElse: () => Division(id: '', name: '', value: ''),
    );
    
    if (division.id.isEmpty) return [];
    
    // Get districts for this division
    return _districts
        .where((d) => d.divisionId == division.id)
        .map((d) => d.value)
        .toList();
  }
  
  List<String> getUpazilasByDistrict(String districtValue) {
    // Find the district ID by value
    final district = _districts.firstWhere(
      (d) => d.value == districtValue,
      orElse: () => District(id: '', divisionId: '', label: '', value: ''),
    );
    
    if (district.id.isEmpty) return [];
    
    // Get upazilas for this district
    return _upazilas
        .where((u) => u.districtId == district.id)
        .map((u) => u.value)
        .toList();
  }
  
  // Get district value from a district ID
  String? getDistrictValueById(String districtId) {
    final district = _districts.firstWhere(
      (d) => d.id == districtId,
      orElse: () => District(id: '', divisionId: '', label: '', value: ''),
    );
    return district.value.isEmpty ? null : district.value;
  }
  
  // Get division value from a division ID
  String? getDivisionValueById(String divisionId) {
    final division = _divisions.firstWhere(
      (d) => d.id == divisionId,
      orElse: () => Division(id: '', name: '', value: ''),
    );
    return division.value.isEmpty ? null : division.value;
  }
}
