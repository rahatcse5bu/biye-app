import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/biodata_entity.dart';
import '../repositories/biodata_repository.dart';

class GetBiodatasUseCase implements UseCase<List<BiodataEntity>, GetBiodatasParams> {
  final BiodataRepository repository;
  
  GetBiodatasUseCase(this.repository);
  
  @override
  Future<Either<Failure, List<BiodataEntity>>> call(GetBiodatasParams params) async {
    return await repository.getBiodatas(
      page: params.page,
      limit: params.limit,
      filters: params.filters,
    );
  }
}

class GetBiodatasParams {
  final int page;
  final int limit;
  final Map<String, dynamic>? filters;
  
  GetBiodatasParams({
    this.page = 1,
    this.limit = 20,
    this.filters,
  });
}
