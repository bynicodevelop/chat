import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/messaging.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:equatable/equatable.dart';

part 'discussion_list_event.dart';
part 'discussion_list_state.dart';

class DiscussionListBloc
    extends Bloc<DiscussionListEvent, DiscussionListState> {
  final MessagingRepository _messagingRepositry;

  DiscussionListBloc(
    this._messagingRepositry,
  ) : super(DiscussionListInitialState());

  @override
  Stream<DiscussionListState> mapEventToState(
    DiscussionListEvent event,
  ) async* {
    if (event is DiscussionListInitializeEvent) {
      this._messagingRepositry.discussions.listen((discussions) {
        add(_DiscussionListInitializeEvent(
          discussions: discussions,
        ));
      });
    } else if (event is _DiscussionListInitializeEvent) {
      yield DiscussionListInitialState(
        discussions: event.discussions,
      );
    }
  }
}
