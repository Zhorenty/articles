import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:new_udemy_course/core/usecases/usecase.dart';

import '../../../core/error/failure.dart';
import '../entities/person_entity.dart';
import '../repository/person_repository.dart';

class SearchPerson extends UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository personRepository;
  SearchPerson({required this.personRepository});

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      SearchPersonParams params) async {
    return personRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;

  const SearchPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}
