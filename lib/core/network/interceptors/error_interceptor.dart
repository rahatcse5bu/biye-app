import 'package:dio/dio.dart';
import '../../errors/exceptions.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw NetworkException('Connection timeout. Please check your internet connection.');
      
      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final message = err.response?.data?['message'] ?? 'An error occurred';
        
        switch (statusCode) {
          case 400:
            throw ValidationException(message);
          case 401:
            throw UnauthorizedException('Unauthorized. Please login again.');
          case 403:
            throw UnauthorizedException('Access forbidden.');
          case 404:
            throw ServerException('Resource not found.', statusCode: statusCode);
          case 500:
          case 502:
          case 503:
            throw ServerException('Server error. Please try again later.', statusCode: statusCode);
          default:
            throw ServerException(message, statusCode: statusCode);
        }
      
      case DioExceptionType.cancel:
        throw ServerException('Request was cancelled.');
      
      case DioExceptionType.unknown:
        if (err.error.toString().contains('SocketException')) {
          throw NetworkException('No internet connection.');
        }
        throw ServerException('Unexpected error occurred.');
      
      default:
        throw ServerException('Unexpected error occurred.');
    }
  }
}
