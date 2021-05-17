import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:equatable/equatable.dart';

part 'discussion_event.dart';
part 'discussion_state.dart';

class DiscussionBloc extends Bloc<DiscussionEvent, DiscussionState> {
  DiscussionBloc() : super(DiscussionInitialState());

  @override
  Stream<DiscussionState> mapEventToState(
    DiscussionEvent event,
  ) async* {
    if (event is DiscussionInitializedEvent) {
      if (event.discussions.length > 0) {
        GroupModel? discussion;

        int index =
            event.discussions.indexWhere((groupModel) => groupModel.selected);

        if (index == -1) {
          discussion = event.discussions.firstWhere(
            (message) => message.status == event.status,
          );
        } else {
          discussion = event.discussions.elementAt(index);
        }

        yield DiscussionInitialState(
          discussion: discussion,
          status: event.status,
        );
      }
    }
  }
}
