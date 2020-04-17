import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mas_notas/Authentication/authenticate_state.dart';
import 'package:mas_notas/models/user.dart';
import 'package:mas_notas/repositories/authenticate_repository.dart';

import 'authenticate_event.dart';

class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  AuthRepository userRepository = AuthRepository();
  @override
  AuthenticateState get initialState => AuthenticateInitial();

  @override
  Stream<AuthenticateState> mapEventToState(
    AuthenticateEvent event,
  ) async* {
    if (event is OnRegister) {
      yield Authenticating();
      User user = await userRepository.register(event.user);
      if (user != null) {
        yield Authenticated(user: user);
      } else {
        yield AuthenticateError(message: "Error al Registrar");
      }
    } else if (event is OnLogin) {
      yield Authenticating();
      User user = await userRepository.login(event.user);
      if (user != null) {
        yield Authenticated(user: user);
      } else {
        yield AuthenticateError(message: "Error al Iniciar Sesion");
      }
    }
  }
}
