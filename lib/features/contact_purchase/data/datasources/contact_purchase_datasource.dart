import '../../../../core/network/dio_client.dart';
import '../models/contact_purchase_model.dart';

class ContactPurchaseDatasource {
  final DioClient _dioClient;

  ContactPurchaseDatasource(this._dioClient);

  Future<ContactPurchaseResponse> purchaseContact({
    required String bioUser,
  }) async {
    try {
      final response = await _dioClient.post(
        '/contact-purchase-data',
        data: ContactPurchaseRequest(bioUser: bioUser).toJson(),
      );

      return ContactPurchaseResponse.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
