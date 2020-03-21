import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:mas_notas/Authentication/authenticate_state.dart';
import 'package:mas_notas/models/user.dart';
import 'package:mas_notas/repositories/register_repository.dart';

import 'authenticate_event.dart';


class AuthenticateBloc extends Bloc<AuthenticateEvent, AuthenticateState> {
  RegisterUser userRepository = RegisterUser();
  @override
  AuthenticateState get initialState => AuthenticateInitial();

  @override
  Stream<AuthenticateState> mapEventToState(
    AuthenticateEvent event,
  ) async* {
    if (event is OnRegister) {
      yield Registering();
      try {
        User user = await userRepository.register(event.user);
        yield Authenticated(user: user);
      } catch (e) {
        print(e.toString());
        yield RegisterError(message: e.toString());
      }
    }
  }
}
