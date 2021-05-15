part of 'pageview_bloc.dart';

abstract class PageViewEvent extends Equatable {
  const PageViewEvent();

  @override
  List<Object> get props => [];
}

class PageViewInitializeEvent extends PageViewEvent {}

class PageViewJumpToPage extends PageViewEvent {
  final int index;

  PageViewJumpToPage(this.index);
}
