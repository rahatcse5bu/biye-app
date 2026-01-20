import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../data/datasources/contact_purchase_datasource.dart';
import '../../data/datasources/bio_choice_datasource.dart';
import '../../../../core/network/dio_client.dart';

// Datasource providers
final contactPurchaseDatasourceProvider = Provider<ContactPurchaseDatasource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContactPurchaseDatasource(dioClient);
});

final bioChoiceDatasourceProvider = Provider<BioChoiceDatasource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BioChoiceDatasource(dioClient);
});

// State for bio choice and purchase operation
class ContactPurchaseState {
  final bool isLoading;
  final String? errorMessage;
  final bool? purchaseSuccess;
  final String? bioChoiceStatus; // pending, approved, rejected, null if not exists
  final bool bioChoiceChecked; // Whether we've checked bio choice status
  final Map<String, dynamic>? contactInfo; // Purchased contact info if already bought
  final bool alreadyPurchased; // Whether user already purchased this contact

  ContactPurchaseState({
    this.isLoading = false,
    this.errorMessage,
    this.purchaseSuccess,
    this.bioChoiceStatus,
    this.bioChoiceChecked = false,
    this.contactInfo,
    this.alreadyPurchased = false,
  });

  ContactPurchaseState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? purchaseSuccess,
    String? bioChoiceStatus,
    bool? bioChoiceChecked,
    Map<String, dynamic>? contactInfo,
    bool? alreadyPurchased,
  }) {
    return ContactPurchaseState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      purchaseSuccess: purchaseSuccess,
      bioChoiceStatus: bioChoiceStatus,
      bioChoiceChecked: bioChoiceChecked ?? this.bioChoiceChecked,
      contactInfo: contactInfo,
      alreadyPurchased: alreadyPurchased ?? this.alreadyPurchased,
    );
  }
}

// StateNotifier for managing purchase state
class ContactPurchaseNotifier extends StateNotifier<ContactPurchaseState> {
  final ContactPurchaseDatasource _purchaseDatasource;
  final BioChoiceDatasource _bioChoiceDatasource;

  ContactPurchaseNotifier(
    this._purchaseDatasource,
    this._bioChoiceDatasource,
  ) : super(ContactPurchaseState());

  /// Check purchase and bio choice status
  Future<void> checkStatus(String bioUser) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // First check if already purchased
      final contactInfo = await _bioChoiceDatasource.checkIfPurchased(bioUser: bioUser);
      
      if (contactInfo != null) {
        // Already purchased, set contact info
        state = state.copyWith(
          isLoading: false,
          alreadyPurchased: true,
          contactInfo: contactInfo,
          bioChoiceChecked: true,
        );
        return;
      }

      // Not purchased yet, check bio choice status
      final status = await _bioChoiceDatasource.checkBioChoiceStatus(bioUser: bioUser);
      
      state = state.copyWith(
        isLoading: false,
        bioChoiceStatus: status,
        bioChoiceChecked: true,
        alreadyPurchased: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        bioChoiceChecked: true,
      );
    }
  }

  /// Step 1: Send request (create bio choice with pending status)
  Future<bool> sendPurchaseRequest(String bioUser, {String? bioDetails}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final created = await _bioChoiceDatasource.createBioChoice(
        bioUser: bioUser,
        bioDetails: bioDetails,
      );
      
      if (created) {
        // After creating, update status to pending
        state = state.copyWith(
          isLoading: false,
          bioChoiceStatus: 'pending',
          bioChoiceChecked: true,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'অনুরোধ পাঠাতে ব্যর্থ হয়েছে',
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  /// Fetch questions for a biodata owner
  Future<List<String>> fetchQuestions(String bioUser) async {
    try {
      return await _bioChoiceDatasource.getQuestionsByUser(bioUser);
    } catch (e) {
      return [];
    }
  }

  /// Step 2: Purchase contact (only if approved)
  Future<bool> purchaseContact(String bioUser) async {
    state = state.copyWith(isLoading: true, errorMessage: null, purchaseSuccess: null);

    try {
      final response = await _purchaseDatasource.purchaseContact(bioUser: bioUser);
      
      if (response.success) {
        state = state.copyWith(
          isLoading: false,
          purchaseSuccess: true,
        );
        return true;
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: response.message,
          purchaseSuccess: false,
        );
        return false;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
        purchaseSuccess: false,
      );
      return false;
    }
  }

  void reset() {
    state = ContactPurchaseState();
  }
}

// Provider for the notifier
final contactPurchaseProvider = StateNotifierProvider<ContactPurchaseNotifier, ContactPurchaseState>((ref) {
  final purchaseDatasource = ref.watch(contactPurchaseDatasourceProvider);
  final bioChoiceDatasource = ref.watch(bioChoiceDatasourceProvider);
  return ContactPurchaseNotifier(purchaseDatasource, bioChoiceDatasource);
});
