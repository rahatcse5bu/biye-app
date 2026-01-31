import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> loginWithGoogle();
  Future<UserModel> refreshUserData();
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  
  AuthRemoteDataSourceImpl({
    required this.dioClient,
    required this.firebaseAuth,
    required this.googleSignIn,
  });
  
  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      // Sign in with Google
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        throw Exception('Google sign in aborted');
      }

      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final userCredential = await firebaseAuth.signInWithCredential(credential);
      final user = userCredential.user;
      
      if (user == null) {
        throw Exception('Firebase user is null');
      }

      // Get Firebase ID token
      final idToken = await user.getIdToken();

      // Send to backend to create/login user
      final response = await dioClient.post(
        '/user-info/create-login-user/app',
        data: {
          'email': user.email,
          'token_id': idToken,
          'user_role': 'user',
          'user_status': 'active',
          if (user.displayName != null) 'name': user.displayName,
        },
      );

      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Login failed');
      }

      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
  
  @override
  Future<UserModel> refreshUserData() async {
    try {
      // Get fresh user data from backend
      final response = await dioClient.get('/user-info/verify');

      if (response.data['success'] != true) {
        throw Exception(response.data['message'] ?? 'Failed to refresh user data');
      }

      return UserModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception('Failed to refresh user data: $e');
    }
  }
  
  @override
  Future<void> logout() async {
    await Future.wait([
      googleSignIn.signOut(),
      firebaseAuth.signOut(),
    ]);
  }
}
