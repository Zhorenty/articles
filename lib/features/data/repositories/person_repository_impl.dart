import 'package:new_udemy_course/core/error/exception.dart';
import 'package:new_udemy_course/core/platform/network_info.dart';
import 'package:new_udemy_course/features/data/datasources/person_local_datasource.dart';
import 'package:new_udemy_course/features/data/datasources/person_remote_datasource.dart';
import 'package:new_udemy_course/features/domain/entities/person_entity.dart';
import 'package:new_udemy_course/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:new_udemy_course/features/domain/repository/person_repository.dart';

import '../models/person_model.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return _getPersons(() {
      return remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async {
    return _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(
      Future<List<PersonModel>> Function() getPersons) async {
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDataSource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDataSource.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
