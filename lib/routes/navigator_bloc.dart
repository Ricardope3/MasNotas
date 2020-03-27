import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  @override
  NavigatorState get initialState => NavigatorInitial();
  // final GlobalKey<NavigatorState> navigatorKey;

  @override
  Stream<NavigatorState> mapEventToState(
    NavigatorEvent event,
  ) async* {
    if(event is OnNavigationPop){
    }
  }
}
