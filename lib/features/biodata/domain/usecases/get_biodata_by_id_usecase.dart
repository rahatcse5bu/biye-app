import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/biodata_entity.dart';
import '../repositories/biodata_repository.dart';

class GetBiodataByIdUseCase implements UseCase<BiodataEntity, String> {
  final BiodataRepository repository;
  
  GetBiodataByIdUseCase(this.repository);
  
  @override
  Future<Either<Failure, BiodataEntity>> call(String id) async {
    return await repository.getBiodataById(id);
  }
}
