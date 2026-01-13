import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/user_model.dart';
import 'dart:convert';

abstract class AuthLocalDataSource {
  Future<void> cacheUser(UserModel user);
  Future<UserModel> getCachedUser();
  Future<void> clearCache();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<bool> isLoggedIn();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  
  static const String cachedUserKey = 'CACHED_USER';
  
  AuthLocalDataSourceImpl(this.sharedPreferences);
  
  @override
  Future<void> cacheUser(UserModel user) async {
    final jsonString = jsonEncode(user.toJson());
    await sharedPreferences.setString(cachedUserKey, jsonString);
    await sharedPreferences.setBool(AppConstants.isLoggedInKey, true);
  }
  
  @override
  Future<UserModel> getCachedUser() async {
    final jsonString = sharedPreferences.getString(cachedUserKey);
    if (jsonString != null) {
      return UserModel.fromJson(jsonDecode(jsonString));
    } else {
      throw CacheException('No cached user found');
    }
  }
  
  @override
  Future<void> clearCache() async {
    await sharedPreferences.remove(cachedUserKey);
    await sharedPreferences.remove(AppConstants.accessTokenKey);
    await sharedPreferences.remove(AppConstants.refreshTokenKey);
    await sharedPreferences.setBool(AppConstants.isLoggedInKey, false);
  }
  
  @override
  Future<void> saveToken(String token) async {
    await sharedPreferences.setString(AppConstants.accessTokenKey, token);
  }
  
  @override
  Future<String?> getToken() async {
    return sharedPreferences.getString(AppConstants.accessTokenKey);
  }
  
  @override
  Future<bool> isLoggedIn() async {
    return sharedPreferences.getBool(AppConstants.isLoggedInKey) ?? false;
  }
}
