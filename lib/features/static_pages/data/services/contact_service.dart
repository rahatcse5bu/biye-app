import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';

class ContactService {
  final DioClient _dioClient;

  ContactService(this._dioClient);

  /// Send contact form email to admin
  /// API: POST /contact/send-email
  /// Body: { name, email, phone, bio, message }
  /// Response: { success: true, message: "Email sent successfully" }
  Future<bool> sendContactEmail({
    required String name,
    required String email,
    required String phone,
    String? bio,
    required String message,
  }) async {
    try {
      final response = await _dioClient.post(
        '/contact/send-email',
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'bio': bio ?? '',
          'message': message,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data['success'] == true;
      }
      return false;
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Failed to send contact email');
    } catch (e) {
      throw Exception('Failed to send contact email: $e');
    }
  }
}
