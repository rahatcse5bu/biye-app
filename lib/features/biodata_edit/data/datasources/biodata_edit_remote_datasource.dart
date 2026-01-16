import '../../../../core/network/dio_client.dart';
import '../models/general_info_edit_model.dart';
import '../models/address_edit_model.dart';
import '../models/educational_qualification_edit_model.dart';
import '../models/family_status_edit_model.dart';
import '../models/personal_info_edit_model.dart';
import '../models/occupation_edit_model.dart';
import '../models/marital_info_edit_model.dart';
import '../models/expected_partner_edit_model.dart';
import '../models/contact_edit_model.dart';
import '../models/ongikar_nama_edit_model.dart';
import '../models/location_models.dart';

class BiodataEditRemoteDataSource {
  final DioClient dioClient;

  BiodataEditRemoteDataSource(this.dioClient);

  // === General Info ===
  Future<GeneralInfoEditModel> getGeneralInfo() async {
    try {
      final response = await dioClient.get('/general-info/token');
      if (response.data['success'] == true) {
        return GeneralInfoEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch general info');
    } catch (e) {
      throw Exception('Error fetching general info: $e');
    }
  }

  Future<void> updateGeneralInfo(GeneralInfoEditModel model) async {
    try {
      await dioClient.put('/general-info', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating general info: $e');
    }
  }

  Future<void> createGeneralInfo(GeneralInfoEditModel model) async {
    try {
      await dioClient.post('/general-info', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating general info: $e');
    }
  }

  // === Address ===
  Future<AddressEditModel> getAddress() async {
    try {
      final response = await dioClient.get('/address/token');
      if (response.data['success'] == true) {
        return AddressEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch address');
    } catch (e) {
      throw Exception('Error fetching address: $e');
    }
  }

  Future<void> updateAddress(AddressEditModel model) async {
    try {
      await dioClient.put('/address', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating address: $e');
    }
  }

  Future<void> createAddress(AddressEditModel model) async {
    try {
      await dioClient.post('/address', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating address: $e');
    }
  }

  // === Educational Qualification ===
  Future<EducationalQualificationEditModel> getEducationalQualification() async {
    try {
      final response = await dioClient.get('/educational-qualification/token');
      if (response.data['success'] == true) {
        return EducationalQualificationEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch educational qualification');
    } catch (e) {
      throw Exception('Error fetching educational qualification: $e');
    }
  }

  Future<void> updateEducationalQualification(EducationalQualificationEditModel model) async {
    try {
      await dioClient.put('/educational-qualification', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating educational qualification: $e');
    }
  }

  Future<void> createEducationalQualification(EducationalQualificationEditModel model) async {
    try {
      await dioClient.post('/educational-qualification', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating educational qualification: $e');
    }
  }

  // === Family Status ===
  Future<FamilyStatusEditModel> getFamilyStatus() async {
    try {
      final response = await dioClient.get('/family-status/token');
      if (response.data['success'] == true) {
        return FamilyStatusEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch family status');
    } catch (e) {
      throw Exception('Error fetching family status: $e');
    }
  }

  Future<void> updateFamilyStatus(FamilyStatusEditModel model) async {
    try {
      await dioClient.put('/family-status', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating family status: $e');
    }
  }

  Future<void> createFamilyStatus(FamilyStatusEditModel model) async {
    try {
      await dioClient.post('/family-status', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating family status: $e');
    }
  }

  // === Personal Info ===
  Future<PersonalInfoEditModel> getPersonalInfo() async {
    try {
      final response = await dioClient.get('/personal-info/token');
      if (response.data['success'] == true) {
        return PersonalInfoEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch personal info');
    } catch (e) {
      throw Exception('Error fetching personal info: $e');
    }
  }

  Future<void> updatePersonalInfo(PersonalInfoEditModel model) async {
    try {
      await dioClient.put('/personal-info', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating personal info: $e');
    }
  }

  Future<void> createPersonalInfo(PersonalInfoEditModel model) async {
    try {
      await dioClient.post('/personal-info', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating personal info: $e');
    }
  }

  // === Occupation ===
  Future<OccupationEditModel> getOccupation() async {
    try {
      final response = await dioClient.get('/occupation/token');
      if (response.data['success'] == true) {
        return OccupationEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch occupation');
    } catch (e) {
      throw Exception('Error fetching occupation: $e');
    }
  }

  Future<void> updateOccupation(OccupationEditModel model) async {
    try {
      await dioClient.put('/occupation', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating occupation: $e');
    }
  }

  Future<void> createOccupation(OccupationEditModel model) async {
    try {
      await dioClient.post('/occupation', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating occupation: $e');
    }
  }

  // === Marital Info ===
  Future<MaritalInfoEditModel> getMaritalInfo() async {
    try {
      final response = await dioClient.get('/marital-info/token');
      if (response.data['success'] == true) {
        return MaritalInfoEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch marital info');
    } catch (e) {
      throw Exception('Error fetching marital info: $e');
    }
  }

  Future<void> updateMaritalInfo(MaritalInfoEditModel model) async {
    try {
      await dioClient.put('/marital-info', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating marital info: $e');
    }
  }

  Future<void> createMaritalInfo(MaritalInfoEditModel model) async {
    try {
      await dioClient.post('/marital-info', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating marital info: $e');
    }
  }

  // === Expected Partner ===
  Future<ExpectedPartnerEditModel> getExpectedPartner() async {
    try {
      final response = await dioClient.get('/expected-lifepartner/token');
      if (response.data['success'] == true) {
        return ExpectedPartnerEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch expected partner');
    } catch (e) {
      throw Exception('Error fetching expected partner: $e');
    }
  }

  Future<void> updateExpectedPartner(ExpectedPartnerEditModel model) async {
    try {
      await dioClient.put('/expected-lifepartner', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating expected partner: $e');
    }
  }

  Future<void> createExpectedPartner(ExpectedPartnerEditModel model) async {
    try {
      await dioClient.post('/expected-lifepartner', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating expected partner: $e');
    }
  }

  // === Contact ===
  Future<ContactEditModel> getContact() async {
    try {
      final response = await dioClient.get('/contact/token');
      if (response.data['success'] == true) {
        return ContactEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch contact');
    } catch (e) {
      throw Exception('Error fetching contact: $e');
    }
  }

  Future<void> updateContact(ContactEditModel model) async {
    try {
      await dioClient.put('/contact', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating contact: $e');
    }
  }

  Future<void> createContact(ContactEditModel model) async {
    try {
      await dioClient.post('/contact', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating contact: $e');
    }
  }

  // === Ongikar Nama ===
  Future<OngikarNamaEditModel> getOngikarNama() async {
    try {
      final response = await dioClient.get('/ongikar-nama/token');
      if (response.data['success'] == true) {
        return OngikarNamaEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch ongikar nama');
    } catch (e) {
      throw Exception('Error fetching ongikar nama: $e');
    }
  }

  Future<void> updateOngikarNama(OngikarNamaEditModel model) async {
    try {
      await dioClient.put('/ongikar-nama', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating ongikar nama: $e');
    }
  }

  Future<void> createOngikarNama(OngikarNamaEditModel model) async {
    try {
      await dioClient.post('/ongikar-nama', data: model.toJson());
    } catch (e) {
      throw Exception('Error creating ongikar nama: $e');
    }
  }

  // === Location Data ===
  Future<List<Division>> getDivisions() async {
    try {
      final response = await dioClient.get('/general-info/divisions');
      if (response.data is List) {
        return (response.data as List)
            .map((e) => Division.fromJson(e))
            .toList();
      }
      throw Exception('Invalid divisions data format');
    } catch (e) {
      throw Exception('Error fetching divisions: $e');
    }
  }

  Future<List<District>> getDistricts() async {
    try {
      final response = await dioClient.get('/general-info/districts');
      if (response.data is List) {
        return (response.data as List)
            .map((e) => District.fromJson(e))
            .toList();
      }
      throw Exception('Invalid districts data format');
    } catch (e) {
      throw Exception('Error fetching districts: $e');
    }
  }

  Future<List<Upzila>> getUpzilas() async {
    try {
      final response = await dioClient.get('/general-info/upzilas');
      if (response.data is List) {
        return (response.data as List)
            .map((e) => Upzila.fromJson(e))
            .toList();
      }
      throw Exception('Invalid upzilas data format');
    } catch (e) {
      throw Exception('Error fetching upzilas: $e');
    }
  }
}
