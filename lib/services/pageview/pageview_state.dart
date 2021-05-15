part of 'pageview_bloc.dart';

abstract class PageViewState extends Equatable {
  const PageViewState();

  @override
  List<Object> get props => [];
}

class PageViewInitialState extends PageViewState {
  final int indexSelected;

  PageViewInitialState({
    this.indexSelected = 0,
  });

  @override
  List<Object> get props => [indexSelected];
}
