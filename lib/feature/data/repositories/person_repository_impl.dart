import 'package:rick_and_morty_app/core/error/exception.dart';
import 'package:rick_and_morty_app/core/platform/network_info.dart';
import 'package:rick_and_morty_app/feature/data/dataSources/person_data_local_source.dart';
import 'package:rick_and_morty_app/feature/data/dataSources/person_remote_data_source.dart';
import 'package:rick_and_morty_app/feature/data/models/person_model.dart';
import 'package:rick_and_morty_app/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_app/feature/domain/repository/person_repository.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource personRemoteDataSource;
  final PersonDataLocalSource personDataLocalSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.personRemoteDataSource,
    required this.personDataLocalSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return personRemoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return await _getPersons(() {
      return personRemoteDataSource.searcPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePersons = await getPersons();
        personDataLocalSource.personsToCache(remotePersons);
        return Right(remotePersons);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final locatePersons =
            await personDataLocalSource.getLastPersonsFromCache();
        return Right(locatePersons);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
