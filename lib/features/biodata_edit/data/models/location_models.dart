class Division {
  final String id;
  final String name;
  final String value;
  final String lat;
  final String long;

  Division({
    required this.id,
    required this.name,
    required this.value,
    required this.lat,
    required this.long,
  });

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
      lat: json['lat']?.toString() ?? '',
      long: json['long']?.toString() ?? '',
    );
  }
}

class District {
  final String id;
  final String divisionId;
  final String label;
  final String value;
  final String lat;
  final String long;

  District({
    required this.id,
    required this.divisionId,
    required this.label,
    required this.value,
    required this.lat,
    required this.long,
  });

  factory District.fromJson(Map<String, dynamic> json) {
    return District(
      id: json['id']?.toString() ?? '',
      divisionId: json['division_id']?.toString() ?? '',
      label: json['label']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
      lat: json['lat']?.toString() ?? '',
      long: json['long']?.toString() ?? '',
    );
  }
}

class Upzila {
  final String id;
  final String districtId;
  final String name;
  final String value;

  Upzila({
    required this.id,
    required this.districtId,
    required this.name,
    required this.value,
  });

  factory Upzila.fromJson(Map<String, dynamic> json) {
    return Upzila(
      id: json['id']?.toString() ?? '',
      districtId: json['district_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
    );
  }
}
