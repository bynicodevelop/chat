import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'chat_groups_item_event.dart';
part 'chat_groups_item_state.dart';

class ChatGroupsItemBloc
    extends Bloc<ChatGroupsItemEvent, ChatGroupsItemState> {
  ChatGroupsItemBloc() : super(ChatGroupsItemInitialState());

  @override
  Stream<ChatGroupsItemState> mapEventToState(
    ChatGroupsItemEvent event,
  ) async* {
    if (event is ChatGroupsItemSelectedEvent) {
      yield ChatGroupsItemInitialState(
        itemSelected: event.itemSelected,
      );
    }
  }
}
