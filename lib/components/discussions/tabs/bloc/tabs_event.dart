part of 'tabs_bloc.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();

  @override
  List<Object> get props => [];
}

class TabsChangedEvent extends TabsEvent {
  final int index;

  TabsChangedEvent({
    required this.index,
  });
}
