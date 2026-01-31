import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/biodata_entity.dart';
import '../../domain/repositories/biodata_repository.dart';
import '../datasources/biodata_remote_datasource.dart';

class BiodataRepositoryImpl implements BiodataRepository {
  final BiodataRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  
  BiodataRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
  
  @override
  Future<Either<Failure, List<BiodataEntity>>> getBiodatas({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }
    
    try {
      final models = await remoteDataSource.getBiodatas(
        page: page,
        limit: limit,
        filters: filters,
      );
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, BiodataEntity>> getBiodataById(String id) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure('No internet connection'));
    }
    
    try {
      final model = await remoteDataSource.getBiodataById(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } catch (e) {
      return Left(UnknownFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, BiodataEntity>> createBiodata(BiodataEntity biodata) async {
    // TODO: Implement when backend API is ready
    return const Left(ServerFailure('Not implemented yet'));
  }
  
  @override
  Future<Either<Failure, BiodataEntity>> updateBiodata(BiodataEntity biodata) async {
    // TODO: Implement when backend API is ready
    return const Left(ServerFailure('Not implemented yet'));
  }
  
  @override
  Future<Either<Failure, void>> deleteBiodata(String id) async {
    // TODO: Implement when backend API is ready
    return const Left(ServerFailure('Not implemented yet'));
  }
}
