import 'package:dartz/dartz.dart';
import 'package:new_udemy_course/features/domain/entities/person_entity.dart';

import '../../../core/error/failure.dart';

abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
