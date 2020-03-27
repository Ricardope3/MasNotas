part of 'navigator_bloc.dart';

abstract class NavigatorEvent extends Equatable {
  const NavigatorEvent();
}

class OnNavigationPop extends NavigatorEvent {
  @override
  List<Object> get props => null;
}

class OnSignInRouting extends NavigatorEvent {
  @override
  List<Object> get props => null;
}

class OnRegisterRouting extends NavigatorEvent {
  @override
  List<Object> get props => null;
}

class OnHomeRouting extends NavigatorEvent{
  @override
  List<Object> get props => null;
}