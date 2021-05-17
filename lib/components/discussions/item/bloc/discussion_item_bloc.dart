import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:equatable/equatable.dart';

part 'discussion_item_event.dart';
part 'discussion_item_state.dart';

class DiscussionItemBloc
    extends Bloc<DiscussionItemEvent, DiscussionItemState> {
  DiscussionItemBloc() : super(DiscussionItemInitialState());

  @override
  Stream<DiscussionItemState> mapEventToState(
    DiscussionItemEvent event,
  ) async* {
    if (event is DiscussionItemSelectedEvent) {
      yield DiscussionItemInitialState(
        itemSelected: event.groupModelSelected.channelId,
      );
    }
  }
}
