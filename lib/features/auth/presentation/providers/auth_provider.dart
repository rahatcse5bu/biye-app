import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../../../core/providers/network_provider.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/is_logged_in_usecase.dart';
import '../../domain/usecases/login_with_google_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/refresh_user_data_usecase.dart';
import 'auth_state.dart';

// Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
});

// Firebase and Google Sign-In Providers
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final googleSignInProvider = Provider<GoogleSignIn>((ref) {
  return GoogleSignIn();
});

// Data Sources
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final googleSignIn = ref.watch(googleSignInProvider);
  return AuthRemoteDataSourceImpl(
    dioClient: dioClient,
    firebaseAuth: firebaseAuth,
    googleSignIn: googleSignIn,
  );
});

final authLocalDataSourceProvider = Provider<AuthLocalDataSource>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return AuthLocalDataSourceImpl(sharedPrefs);
});

// Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  final localDataSource = ref.watch(authLocalDataSourceProvider);
  final networkInfo = ref.watch(networkInfoProvider);
  
  return AuthRepositoryImpl(
    remoteDataSource: remoteDataSource,
    localDataSource: localDataSource,
    networkInfo: networkInfo,
  );
});

// Use Cases
final loginWithGoogleUseCaseProvider = Provider<LoginWithGoogleUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginWithGoogleUseCase(repository);
});

final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return GetCurrentUserUseCase(repository);
});

final isLoggedInUseCaseProvider = Provider<IsLoggedInUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return IsLoggedInUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
});

final refreshUserDataUseCaseProvider = Provider<RefreshUserDataUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RefreshUserDataUseCase(repository);
});

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final IsLoggedInUseCase isLoggedInUseCase;
  final LogoutUseCase logoutUseCase;
  final RefreshUserDataUseCase refreshUserDataUseCase;
  
  AuthNotifier({
    required this.loginWithGoogleUseCase,
    required this.getCurrentUserUseCase,
    required this.isLoggedInUseCase,
    required this.logoutUseCase,
    required this.refreshUserDataUseCase,
  }) : super(const AuthState.initial()) {
    checkAuthStatus();
  }
  
  Future<void> checkAuthStatus() async {
    final isLoggedIn = await isLoggedInUseCase();
    if (isLoggedIn) {
      // First load cached user for immediate UI update
      final cachedUser = await getCurrentUserUseCase();
      if (cachedUser != null) {
        state = AuthState.authenticated(cachedUser);
        // Then refresh from server to get latest data (points, etc.)
        await refreshUserPoints();
      } else {
        state = const AuthState.unauthenticated();
      }
    } else {
      state = const AuthState.unauthenticated();
    }
  }
  
  Future<void> loginWithGoogle() async {
    state = const AuthState.loading();
    
    final result = await loginWithGoogleUseCase();
    
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }
  
  Future<void> logout() async {
    state = const AuthState.loading();
    
    final result = await logoutUseCase(NoParams());
    
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (_) => state = const AuthState.unauthenticated(),
    );
  }
  
  /// Refresh user data from server (e.g., after successful payment)
  /// This fetches fresh data from API and updates local cache
  Future<void> refreshUserPoints() async {
    final result = await refreshUserDataUseCase();
    
    result.fold(
      (failure) {
        // Silent fail - keep current state if refresh fails
        // Could log error here if needed
      },
      (user) => state = AuthState.authenticated(user),
    );
  }
}

// Auth State Notifier Provider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginWithGoogleUseCase = ref.watch(loginWithGoogleUseCaseProvider);
  final getCurrentUserUseCase = ref.watch(getCurrentUserUseCaseProvider);
  final isLoggedInUseCase = ref.watch(isLoggedInUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  final refreshUserDataUseCase = ref.watch(refreshUserDataUseCaseProvider);
  
  return AuthNotifier(
    loginWithGoogleUseCase: loginWithGoogleUseCase,
    getCurrentUserUseCase: getCurrentUserUseCase,
    isLoggedInUseCase: isLoggedInUseCase,
    logoutUseCase: logoutUseCase,
    refreshUserDataUseCase: refreshUserDataUseCase,
  );
});
