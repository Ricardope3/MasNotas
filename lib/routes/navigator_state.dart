part of 'navigator_bloc.dart';

abstract class NavigatorState extends Equatable {
  const NavigatorState();
}

class NavigatorInitial extends NavigatorState {
  @override
  List<Object> get props => [];
}
