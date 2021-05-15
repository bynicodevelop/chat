import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pageview_event.dart';
part 'pageview_state.dart';

class PageViewBloc extends Bloc<PageViewEvent, PageViewState> {
  PageViewBloc() : super(PageViewInitialState());

  @override
  Stream<PageViewState> mapEventToState(
    PageViewEvent event,
  ) async* {
    if (event is PageViewInitializeEvent) {
      yield PageViewInitialState();
    } else if (event is PageViewJumpToPage) {
      yield PageViewInitialState(
        indexSelected: event.index,
      );
    }
  }
}
