import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'closet_event.dart';
part 'closet_state.dart';

class ClosetBloc extends Bloc<ClosetEvent, ClosetState> {
  ClosetBloc() : super(ClosetInitial()) {
    on<ClosetEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
