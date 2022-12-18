import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:new_udemy_course/features/domain/entities/person_entity.dart';
import 'package:new_udemy_course/features/domain/repository/person_repository.dart';

import '../../../core/error/failure.dart';
import '../../../core/usecases/usecase.dart';

class GetAllPersons extends UseCase<List<PersonEntity>, PagePersonParams> {
  final PersonRepository personRepository;
  GetAllPersons({required this.personRepository});

  @override
  Future<Either<Failure, List<PersonEntity>>> call(
      PagePersonParams params) async {
    return personRepository.getAllPersons(params.page);
  }
}

class PagePersonParams extends Equatable {
  final int page;

  const PagePersonParams({required this.page});

  @override
  List<Object?> get props => [page];
}
