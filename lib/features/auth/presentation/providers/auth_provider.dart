import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/providers/dio_provider.dart';
import '../../../../core/providers/network_provider.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/datasources/auth_local_datasource.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_state.dart';

// Shared Preferences Provider
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden');
});

// Data Sources
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuthRemoteDataSourceImpl(dioClient);
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
final loginUseCaseProvider = Provider<LoginUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LoginUseCase(repository);
});

final registerUseCaseProvider = Provider<RegisterUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return RegisterUseCase(repository);
});

final logoutUseCaseProvider = Provider<LogoutUseCase>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return LogoutUseCase(repository);
});

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final AuthRepository authRepository;
  
  AuthNotifier({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.authRepository,
  }) : super(const AuthState.initial()) {
    checkAuthStatus();
  }
  
  Future<void> checkAuthStatus() async {
    final result = await authRepository.isLoggedIn();
    result.fold(
      (failure) => state = const AuthState.unauthenticated(),
      (isLoggedIn) async {
        if (isLoggedIn) {
          final userResult = await authRepository.getCurrentUser();
          userResult.fold(
            (failure) => state = const AuthState.unauthenticated(),
            (user) => state = AuthState.authenticated(user),
          );
        } else {
          state = const AuthState.unauthenticated();
        }
      },
    );
  }
  
  Future<void> login(String email, String password) async {
    state = const AuthState.loading();
    
    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );
    
    result.fold(
      (failure) => state = AuthState.error(failure.message),
      (user) => state = AuthState.authenticated(user),
    );
  }
  
  Future<void> register(String email, String password, String name) async {
    state = const AuthState.loading();
    
    final result = await registerUseCase(
      RegisterParams(email: email, password: password, name: name),
    );
    
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
}

// Auth State Notifier Provider
final authNotifierProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final loginUseCase = ref.watch(loginUseCaseProvider);
  final registerUseCase = ref.watch(registerUseCaseProvider);
  final logoutUseCase = ref.watch(logoutUseCaseProvider);
  final authRepository = ref.watch(authRepositoryProvider);
  
  return AuthNotifier(
    loginUseCase: loginUseCase,
    registerUseCase: registerUseCase,
    logoutUseCase: logoutUseCase,
    authRepository: authRepository,
  );
});
