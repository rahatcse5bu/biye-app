import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/biodata_entity.dart';

abstract class BiodataRepository {
  Future<Either<Failure, List<BiodataEntity>>> getBiodatas({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  });
  
  Future<Either<Failure, BiodataEntity>> getBiodataById(String id);
  
  Future<Either<Failure, BiodataEntity>> createBiodata(BiodataEntity biodata);
  
  Future<Either<Failure, BiodataEntity>> updateBiodata(BiodataEntity biodata);
  
  Future<Either<Failure, void>> deleteBiodata(String id);
}
