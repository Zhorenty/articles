import 'package:equatable/equatable.dart';
import 'package:new_udemy_course/features/domain/entities/person_entity.dart';

abstract class PersonSearchState extends Equatable {
  const PersonSearchState();
  @override
  List<Object?> get props => [];
}

//первоначальное состояние поиска
class PersonEmpty extends PersonSearchState {}

//состояние, при котором у нас подгружаются персонажи из сети, когда мы ввели имя
class PersonSearchLoading extends PersonSearchState {}

//загруженный список персонажей
class PersonSearchLoaded extends PersonSearchState {
  final List<PersonEntity> persons;
  const PersonSearchLoaded({required this.persons});

  @override
  List<Object?> get props => [persons];
}

//ошибка
class PersonSearchError extends PersonSearchState {
  final String message;

  const PersonSearchError({required this.message});

  @override
  List<Object?> get props => [message];
}
