import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginWithGoogleUseCase {
  final AuthRepository repository;
  
  LoginWithGoogleUseCase(this.repository);
  
  Future<Either<Failure, UserEntity>> call() async {
    return await repository.loginWithGoogle();
  }
}
