class AddressEditModel {
  final String? id;
  final String? userId;
  final String permanentAddress;
  final String presentAddress;
  final String grownUp;
  final String presentArea;
  final String permanentArea;
  final String zilla;
  final String upzilla;
  final String division;
  final String presentZilla;
  final String presentUpzilla;
  final String presentDivision;
  final String city;
  final int zip;

  AddressEditModel({
    this.id,
    this.userId,
    required this.permanentAddress,
    required this.presentAddress,
    required this.grownUp,
    required this.presentArea,
    required this.permanentArea,
    required this.zilla,
    required this.upzilla,
    required this.division,
    required this.presentZilla,
    required this.presentUpzilla,
    required this.presentDivision,
    required this.city,
    required this.zip,
  });

  factory AddressEditModel.fromJson(Map<String, dynamic> json) {
    return AddressEditModel(
      id: json['_id']?.toString(),
      userId: json['user']?.toString(),
      permanentAddress: json['permanent_address']?.toString() ?? '',
      presentAddress: json['present_address']?.toString() ?? '',
      grownUp: json['grown_up']?.toString() ?? '',
      presentArea: json['present_area']?.toString() ?? '',
      permanentArea: json['permanent_area']?.toString() ?? '',
      zilla: json['zilla']?.toString() ?? '',
      upzilla: json['upzilla']?.toString() ?? '',
      division: json['division']?.toString() ?? '',
      presentZilla: json['present_zilla']?.toString() ?? '',
      presentUpzilla: json['present_upzilla']?.toString() ?? '',
      presentDivision: json['present_division']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      zip: _toInt(json['zip']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) '_id': id,
      if (userId != null) 'user': userId,
      'permanent_address': permanentAddress,
      'present_address': presentAddress,
      'grown_up': grownUp,
      'present_area': presentArea,
      'permanent_area': permanentArea,
      'zilla': zilla,
      'upzilla': upzilla,
      'division': division,
      'present_zilla': presentZilla,
      'present_upzilla': presentUpzilla,
      'present_division': presentDivision,
      'city': city,
      'zip': zip,
    };
  }

  AddressEditModel copyWith({
    String? id,
    String? userId,
    String? permanentAddress,
    String? presentAddress,
    String? grownUp,
    String? presentArea,
    String? permanentArea,
    String? zilla,
    String? upzilla,
    String? division,
    String? presentZilla,
    String? presentUpzilla,
    String? presentDivision,
    String? city,
    int? zip,
  }) {
    return AddressEditModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      permanentAddress: permanentAddress ?? this.permanentAddress,
      presentAddress: presentAddress ?? this.presentAddress,
      grownUp: grownUp ?? this.grownUp,
      presentArea: presentArea ?? this.presentArea,
      permanentArea: permanentArea ?? this.permanentArea,
      zilla: zilla ?? this.zilla,
      upzilla: upzilla ?? this.upzilla,
      division: division ?? this.division,
      presentZilla: presentZilla ?? this.presentZilla,
      presentUpzilla: presentUpzilla ?? this.presentUpzilla,
      presentDivision: presentDivision ?? this.presentDivision,
      city: city ?? this.city,
      zip: zip ?? this.zip,
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  static AddressEditModel empty() {
    return AddressEditModel(
      permanentAddress: '',
      presentAddress: '',
      grownUp: '',
      presentArea: '',
      permanentArea: '',
      zilla: '',
      upzilla: '',
      division: '',
      presentZilla: '',
      presentUpzilla: '',
      presentDivision: '',
      city: '',
      zip: 0,
    );
  }
}
