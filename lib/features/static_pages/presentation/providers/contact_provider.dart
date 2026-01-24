import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/dio_client.dart';
import '../../data/services/contact_service.dart';

/// Provider for DioClient
final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

/// Provider for ContactService
final contactServiceProvider = Provider<ContactService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContactService(dioClient);
});

/// State for contact form submission
enum ContactFormStatus { initial, loading, success, error }

class ContactFormState {
  final ContactFormStatus status;
  final String? errorMessage;

  const ContactFormState({
    this.status = ContactFormStatus.initial,
    this.errorMessage,
  });

  ContactFormState copyWith({
    ContactFormStatus? status,
    String? errorMessage,
  }) {
    return ContactFormState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

/// Notifier for contact form
class ContactFormNotifier extends StateNotifier<ContactFormState> {
  final ContactService _contactService;

  ContactFormNotifier(this._contactService) : super(const ContactFormState());

  Future<void> submitForm({
    required String name,
    required String email,
    required String phone,
    String? bio,
    required String message,
  }) async {
    state = state.copyWith(status: ContactFormStatus.loading);

    try {
      final success = await _contactService.sendContactEmail(
        name: name,
        email: email,
        phone: phone,
        bio: bio,
        message: message,
      );

      if (success) {
        state = state.copyWith(status: ContactFormStatus.success);
      } else {
        state = state.copyWith(
          status: ContactFormStatus.error,
          errorMessage: 'বার্তা পাঠাতে সমস্যা হয়েছে। পরে আবার চেষ্টা করুন।',
        );
      }
    } catch (e) {
      state = state.copyWith(
        status: ContactFormStatus.error,
        errorMessage: 'বার্তা পাঠাতে সমস্যা হয়েছে। পরে আবার চেষ্টা করুন।',
      );
    }
  }

  void reset() {
    state = const ContactFormState();
  }
}

/// Provider for contact form notifier
final contactFormProvider =
    StateNotifierProvider<ContactFormNotifier, ContactFormState>((ref) {
  final contactService = ref.watch(contactServiceProvider);
  return ContactFormNotifier(contactService);
});
