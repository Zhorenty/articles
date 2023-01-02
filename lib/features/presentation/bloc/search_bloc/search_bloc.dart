import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:new_udemy_course/core/error/failure.dart';
import 'package:new_udemy_course/features/domain/usecases/search_persons.dart';
import 'package:new_udemy_course/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:new_udemy_course/features/presentation/bloc/search_bloc/search_state.dart';

const SERVER_FAILURE_MESSAGE = 'Server failure';
const CACHED_FAILURE_MESSAGE = 'Cache failure';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPerson;

  PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty()) {
    on<SearchPersons>(_onEvent);
  }

  FutureOr<void> _onEvent(
      SearchPersons event, Emitter<PersonSearchState> emit) async {
    emit(PersonSearchLoading());
    final failureOrPerson =
        await searchPerson(SearchPersonParams(query: event.personQuery));
    emit(failureOrPerson.fold(
        (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
        (person) => PersonSearchLoaded(persons: person)));
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}

// Старый Блок

// class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
//   final SearchPerson searchPerson; //useCase
//   PersonSearchBloc({required this.searchPerson}) : super(PersonEmpty());

//   Stream<PersonSearchState> mapEventToState(PersonSearchEvent event) async* {
//     if (event is SearchPersons) {
//       yield* _mapFetchPersonsToState(event.personQuery);
//     } else {}
//   }

//   Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
//     yield PersonSearchLoading();

//     final failureOrPerson =
//         await searchPerson(SearchPersonParams(query: personQuery));

//     yield failureOrPerson.fold(
//         (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
//         (person) => PersonSearchLoaded(persons: person));
//   }

//   String _mapFailureToMessage(Failure failure) {
//     switch (failure.runtimeType) {
//       case ServerFailure:
//         return SERVER_FAILURE_MESSAGE;
//       case CacheFailure:
//         return CACHED_FAILURE_MESSAGE;
//       default:
//         return 'unknown error';
//     }
//   }
// }
