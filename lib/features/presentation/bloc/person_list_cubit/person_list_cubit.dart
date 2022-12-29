import 'package:bloc/bloc.dart';
import 'package:new_udemy_course/features/domain/entities/person_entity.dart';
import 'package:new_udemy_course/features/domain/usecases/get_all_persons.dart';
import 'package:new_udemy_course/features/presentation/bloc/person_list_cubit/person_list_state.dart';

import '../../../../core/error/failure.dart';

const SERVER_FAILURE_MESSAGE = 'Server failure';
const CACHED_FAILURE_MESSAGE = 'Cache failure';

class PersonListCubit extends Cubit<PersonState> {
  final GetAllPersons getAllPersons; //useCase
  PersonListCubit({required this.getAllPersons}) : super(PersonEmpty());

  int page = 1;
  void loadPerson() async {
    if (state is PersonLoading) return;

    final currentState = state;

    var oldPerson = <PersonEntity>[];
    if (currentState is PersonLoaded) {
      oldPerson = currentState.personsList;
    }
    emit(PersonLoading(oldPerson, isFirstFetch: page == 1));

    final failureOrPerson = await getAllPersons(PagePersonParams(page: page));

    failureOrPerson
        .fold((error) => PersonError(message: _mapFailureToMessage(error)),
            (character) {
      page++;
      final persons = (state as PersonLoading).oldPersonsList;
      persons.addAll(character);
      emit(PersonLoaded(persons));
    });
  }

  String _mapFailureToMessage(Failure error) {
    switch (error.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'unknown error';
    }
  }
}
