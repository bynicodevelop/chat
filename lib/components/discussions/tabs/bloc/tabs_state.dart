part of 'tabs_bloc.dart';

abstract class TabsState extends Equatable {
  const TabsState();

  @override
  List<Object> get props => [];
}

class TabsInitialState extends TabsState {
  final int index;

  TabsInitialState({
    this.index = 0,
  });

  @override
  List<Object> get props => [index];
}
