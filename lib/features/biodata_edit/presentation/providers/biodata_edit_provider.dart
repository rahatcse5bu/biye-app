import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/biodata_edit_remote_datasource.dart';
import '../../data/models/general_info_edit_model.dart';
import '../../data/models/address_edit_model.dart';
import '../../data/models/educational_qualification_edit_model.dart';
import '../../data/models/family_status_edit_model.dart';
import '../../data/models/personal_info_edit_model.dart';
import '../../data/models/occupation_edit_model.dart';
import '../../data/models/marital_info_edit_model.dart';
import '../../data/models/expected_partner_edit_model.dart';
import '../../data/models/contact_edit_model.dart';
import '../../data/models/ongikar_nama_edit_model.dart';
import '../../data/models/location_models.dart';

// Data Source Provider
final biodataEditRemoteDataSourceProvider = Provider<BiodataEditRemoteDataSource>((ref) {
  return BiodataEditRemoteDataSource(ref.watch(dioClientProvider));
});

// === General Info Providers ===
final generalInfoEditProvider = FutureProvider<GeneralInfoEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getGeneralInfo();
  } catch (e) {
    return GeneralInfoEditModel.empty();
  }
});

final generalInfoEditNotifierProvider =
    StateNotifierProvider<GeneralInfoEditNotifier, GeneralInfoEditModel>((ref) {
  return GeneralInfoEditNotifier(ref);
});

class GeneralInfoEditNotifier extends StateNotifier<GeneralInfoEditModel> {
  final Ref ref;

  GeneralInfoEditNotifier(this.ref) : super(GeneralInfoEditModel.empty());

  void updateModel(GeneralInfoEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateGeneralInfo(state);
      } else {
        await dataSource.createGeneralInfo(state);
      }
    } catch (e) {
      throw Exception('Failed to save general info: $e');
    }
  }
}

// === Address Providers ===
final addressEditProvider = FutureProvider<AddressEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getAddress();
  } catch (e) {
    return AddressEditModel.empty();
  }
});

final addressEditNotifierProvider =
    StateNotifierProvider<AddressEditNotifier, AddressEditModel>((ref) {
  return AddressEditNotifier(ref);
});

class AddressEditNotifier extends StateNotifier<AddressEditModel> {
  final Ref ref;

  AddressEditNotifier(this.ref) : super(AddressEditModel.empty());

  void updateModel(AddressEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateAddress(state);
      } else {
        await dataSource.createAddress(state);
      }
    } catch (e) {
      throw Exception('Failed to save address: $e');
    }
  }
}

// === Educational Qualification Providers ===
final educationalQualificationEditProvider =
    FutureProvider<EducationalQualificationEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getEducationalQualification();
  } catch (e) {
    return EducationalQualificationEditModel.empty();
  }
});

final educationalQualificationEditNotifierProvider = StateNotifierProvider<
    EducationalQualificationEditNotifier,
    EducationalQualificationEditModel>((ref) {
  return EducationalQualificationEditNotifier(ref);
});

class EducationalQualificationEditNotifier
    extends StateNotifier<EducationalQualificationEditModel> {
  final Ref ref;

  EducationalQualificationEditNotifier(this.ref)
      : super(EducationalQualificationEditModel.empty());

  void updateModel(EducationalQualificationEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateEducationalQualification(state);
      } else {
        await dataSource.createEducationalQualification(state);
      }
    } catch (e) {
      throw Exception('Failed to save educational qualification: $e');
    }
  }
}

// === Family Status Providers ===
final familyStatusEditProvider = FutureProvider<FamilyStatusEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getFamilyStatus();
  } catch (e) {
    return FamilyStatusEditModel.empty();
  }
});

final familyStatusEditNotifierProvider =
    StateNotifierProvider<FamilyStatusEditNotifier, FamilyStatusEditModel>((ref) {
  return FamilyStatusEditNotifier(ref);
});

class FamilyStatusEditNotifier extends StateNotifier<FamilyStatusEditModel> {
  final Ref ref;

  FamilyStatusEditNotifier(this.ref) : super(FamilyStatusEditModel.empty());

  void updateModel(FamilyStatusEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateFamilyStatus(state);
      } else {
        await dataSource.createFamilyStatus(state);
      }
    } catch (e) {
      throw Exception('Failed to save family status: $e');
    }
  }
}

// === Personal Info Providers ===
final personalInfoEditProvider = FutureProvider<PersonalInfoEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getPersonalInfo();
  } catch (e) {
    return PersonalInfoEditModel.empty();
  }
});

final personalInfoEditNotifierProvider =
    StateNotifierProvider<PersonalInfoEditNotifier, PersonalInfoEditModel>((ref) {
  return PersonalInfoEditNotifier(ref);
});

class PersonalInfoEditNotifier extends StateNotifier<PersonalInfoEditModel> {
  final Ref ref;

  PersonalInfoEditNotifier(this.ref) : super(PersonalInfoEditModel.empty());

  void updateModel(PersonalInfoEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updatePersonalInfo(state);
      } else {
        await dataSource.createPersonalInfo(state);
      }
    } catch (e) {
      throw Exception('Failed to save personal info: $e');
    }
  }
}

// === Occupation Providers ===
final occupationEditProvider = FutureProvider<OccupationEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getOccupation();
  } catch (e) {
    return OccupationEditModel.empty();
  }
});

final occupationEditNotifierProvider =
    StateNotifierProvider<OccupationEditNotifier, OccupationEditModel>((ref) {
  return OccupationEditNotifier(ref);
});

class OccupationEditNotifier extends StateNotifier<OccupationEditModel> {
  final Ref ref;

  OccupationEditNotifier(this.ref) : super(OccupationEditModel.empty());

  void updateModel(OccupationEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateOccupation(state);
      } else {
        await dataSource.createOccupation(state);
      }
    } catch (e) {
      throw Exception('Failed to save occupation: $e');
    }
  }
}

// === Marital Info Providers ===
final maritalInfoEditProvider = FutureProvider<MaritalInfoEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getMaritalInfo();
  } catch (e) {
    return MaritalInfoEditModel.empty();
  }
});

final maritalInfoEditNotifierProvider =
    StateNotifierProvider<MaritalInfoEditNotifier, MaritalInfoEditModel>((ref) {
  return MaritalInfoEditNotifier(ref);
});

class MaritalInfoEditNotifier extends StateNotifier<MaritalInfoEditModel> {
  final Ref ref;

  MaritalInfoEditNotifier(this.ref) : super(MaritalInfoEditModel.empty());

  void updateModel(MaritalInfoEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateMaritalInfo(state);
      } else {
        await dataSource.createMaritalInfo(state);
      }
    } catch (e) {
      throw Exception('Failed to save marital info: $e');
    }
  }
}

// === Expected Partner Providers ===
final expectedPartnerEditProvider =
    FutureProvider<ExpectedPartnerEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getExpectedPartner();
  } catch (e) {
    return ExpectedPartnerEditModel.empty();
  }
});

final expectedPartnerEditNotifierProvider = StateNotifierProvider<
    ExpectedPartnerEditNotifier, ExpectedPartnerEditModel>((ref) {
  return ExpectedPartnerEditNotifier(ref);
});

class ExpectedPartnerEditNotifier
    extends StateNotifier<ExpectedPartnerEditModel> {
  final Ref ref;

  ExpectedPartnerEditNotifier(this.ref) : super(ExpectedPartnerEditModel.empty());

  void updateModel(ExpectedPartnerEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateExpectedPartner(state);
      } else {
        await dataSource.createExpectedPartner(state);
      }
    } catch (e) {
      throw Exception('Failed to save expected partner: $e');
    }
  }
}

// === Contact Providers ===
final contactEditProvider = FutureProvider<ContactEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getContact();
  } catch (e) {
    return ContactEditModel.empty();
  }
});

final contactEditNotifierProvider =
    StateNotifierProvider<ContactEditNotifier, ContactEditModel>((ref) {
  return ContactEditNotifier(ref);
});

class ContactEditNotifier extends StateNotifier<ContactEditModel> {
  final Ref ref;

  ContactEditNotifier(this.ref) : super(ContactEditModel.empty());

  void updateModel(ContactEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateContact(state);
      } else {
        await dataSource.createContact(state);
      }
    } catch (e) {
      throw Exception('Failed to save contact: $e');
    }
  }
}

// === Ongikar Nama Providers ===
final ongikarNamaEditProvider = FutureProvider<OngikarNamaEditModel>((ref) async {
  try {
    final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
    return await dataSource.getOngikarNama();
  } catch (e) {
    return OngikarNamaEditModel.empty();
  }
});

final ongikarNamaEditNotifierProvider =
    StateNotifierProvider<OngikarNamaEditNotifier, OngikarNamaEditModel>((ref) {
  return OngikarNamaEditNotifier(ref);
});

class OngikarNamaEditNotifier extends StateNotifier<OngikarNamaEditModel> {
  final Ref ref;

  OngikarNamaEditNotifier(this.ref) : super(OngikarNamaEditModel.empty());

  void updateModel(OngikarNamaEditModel model) {
    state = model;
  }

  Future<void> save() async {
    try {
      final dataSource = ref.read(biodataEditRemoteDataSourceProvider);
      if (state.id != null) {
        await dataSource.updateOngikarNama(state);
      } else {
        await dataSource.createOngikarNama(state);
      }
    } catch (e) {
      throw Exception('Failed to save ongikar nama: $e');
    }
  }
}

// === Location Data Providers ===
final divisionsProvider = FutureProvider<List<Division>>((ref) async {
  final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
  return await dataSource.getDivisions();
});

final districtsProvider = FutureProvider<List<District>>((ref) async {
  final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
  return await dataSource.getDistricts();
});

final upzilasProvider = FutureProvider<List<Upzila>>((ref) async {
  final dataSource = ref.watch(biodataEditRemoteDataSourceProvider);
  return await dataSource.getUpzilas();
});

// === Current Step Provider ===
final currentStepNotifierProvider = StateNotifierProvider<CurrentStepNotifier, int>((ref) {
  return CurrentStepNotifier();
});

class CurrentStepNotifier extends StateNotifier<int> {
  CurrentStepNotifier() : super(0);

  void setStep(int step) {
    state = step;
  }

  void nextStep() {
    if (state < 9) {
      state++;
    }
  }

  void previousStep() {
    if (state > 0) {
      state--;
    }
  }
}
