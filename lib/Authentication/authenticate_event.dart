

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:mas_notas/models/user.dart';

abstract class AuthenticateEvent extends Equatable {
  const AuthenticateEvent();
}

class OnRegister extends AuthenticateEvent {

  final User user;
  OnRegister({
    @required this.user,
  });
  @override
  List<Object> get props => [user];
}
