import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class User extends Equatable {
  final String name, email, password;

  User({
    @required this.email,
    this.name,
    @required this.password,
  });
  @override
  List<Object> get props => [name, email, password];
}
