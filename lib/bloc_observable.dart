import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBlocObservable extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('on event -- bloc: ${bloc.runtimeType}, event: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('on error -- bloc: ${bloc.runtimeType}, error - $error');
  }
}
//Помимо, сюда можно подключить какой-нить Firebase analytics,
//куда будут попадать все ошибки