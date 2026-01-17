import 'package:dio/dio.dart';
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return GeneralInfoEditModel.empty();
      }
      return GeneralInfoEditModel.empty();
    } catch (e) {
      return GeneralInfoEditModel.empty();
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return AddressEditModel.empty();
      }
      return AddressEditModel.empty();
    } catch (e) {
      return AddressEditModel.empty();
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return EducationalQualificationEditModel.empty();
      }
      return EducationalQualificationEditModel.empty();
    } catch (e) {
      return EducationalQualificationEditModel.empty();
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return FamilyStatusEditModel.empty();
      }
      return FamilyStatusEditModel.empty();
    } catch (e) {
      return FamilyStatusEditModel.empty();
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return PersonalInfoEditModel.empty();
      }
      return PersonalInfoEditModel.empty();
    } catch (e) {
      return PersonalInfoEditModel.empty();
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return OccupationEditModel.empty();
      }
      return OccupationEditModel.empty();
    } catch (e) {
      return OccupationEditModel.empty();
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return MaritalInfoEditModel.empty();
      }
      return MaritalInfoEditModel.empty();
    } catch (e) {
      return MaritalInfoEditModel.empty();
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
      final response = await dioClient.get('/expected-life-partner/token');
      if (response.data['success'] == true) {
        return ExpectedPartnerEditModel.fromJson(response.data['data']);
      }
      throw Exception('Failed to fetch expected partner');
    } on DioException catch (e) {
      // If 404 or no data found, return empty model
      if (e.response?.statusCode == 404) {
        return ExpectedPartnerEditModel.empty();
      }
      // For other network errors, return empty model as well
      if (e.type == DioExceptionType.unknown || 
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.badResponse) {
        return ExpectedPartnerEditModel.empty();
      }
      throw Exception('Error fetching expected partner: $e');
    } catch (e) {
      // For any other error, return empty model
      return ExpectedPartnerEditModel.empty();
    }
  }

  Future<void> updateExpectedPartner(ExpectedPartnerEditModel model) async {
    try {
      await dioClient.put('/expected-life-partner', data: model.toJson());
    } catch (e) {
      throw Exception('Error updating expected partner: $e');
    }
  }

  Future<void> createExpectedPartner(ExpectedPartnerEditModel model) async {
    try {
      await dioClient.post('/expected-life-partner', data: model.toJson());
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return ContactEditModel.empty();
      }
      return ContactEditModel.empty();
    } catch (e) {
      return ContactEditModel.empty();
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
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return OngikarNamaEditModel.empty();
      }
      return OngikarNamaEditModel.empty();
    } catch (e) {
      return OngikarNamaEditModel.empty();
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

  // === Submit for Review ===
  Future<void> submitForReview() async {
    try {
      await dioClient.put('/user-info', data: {'user_status': 'in review'});
    } catch (e) {
      throw Exception('Error submitting for review: $e');
    }
  }

  // === Location Data ===
  Future<List<Division>> getDivisions() async {
    try {
      final response = await dioClient.get('https://pncnikah.com/divisions.json');
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
      final response = await dioClient.get('https://pncnikah.com/districts.json');
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
      final response = await dioClient.get('https://pncnikah.com/upzila.json');
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
