class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://server.pncnikah.com';
  static const String apiVersion = '/api/v1';
  
  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  
  // User Endpoints
  static const String profile = '/user/profile';
  static const String updateProfile = '/user/update';
  
  // Biodata Endpoints
  static const String biodatas = '/biodatas';
  static const String createBiodata = '/biodatas/create';
  static const String updateBiodata = '/biodatas/update';
  static const String deleteBiodata = '/biodatas/delete';
  
  // Timeout
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
}
