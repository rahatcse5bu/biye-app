import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> loginWithGoogle();
  Future<Either<Failure, UserEntity>> refreshUserData();
  Future<Either<Failure, void>> logout();
  Future<UserEntity?> getCurrentUser();
  Future<bool> isLoggedIn();
}
