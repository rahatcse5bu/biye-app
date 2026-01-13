import '../../../../core/network/dio_client.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  });
  
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient dioClient;
  
  AuthRemoteDataSourceImpl(this.dioClient);
  
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await dioClient.post(
      '/auth/login',
      data: {
        'email': email,
        'password': password,
      },
    );
    
    return UserModel.fromJson(response.data['data']);
  }
  
  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final response = await dioClient.post(
      '/auth/register',
      data: {
        'email': email,
        'password': password,
        'name': name,
      },
    );
    
    return UserModel.fromJson(response.data['data']);
  }
  
  @override
  Future<void> logout() async {
    await dioClient.post('/auth/logout');
  }
}
