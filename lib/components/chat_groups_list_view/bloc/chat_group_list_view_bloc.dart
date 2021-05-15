import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/messaging.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:equatable/equatable.dart';

part 'chat_group_list_view_event.dart';
part 'chat_group_list_view_state.dart';

class ChatGroupListViewBloc
    extends Bloc<ChatGroupListViewEvent, ChatGroupListViewState> {
  final MessagingRepository _messagingRepositry;

  ChatGroupListViewBloc(
    this._messagingRepositry,
  ) : super(ChatGroupListViewInitialState());

  @override
  Stream<ChatGroupListViewState> mapEventToState(
    ChatGroupListViewEvent event,
  ) async* {
    if (event is ChatGroupListViewInitializeEvent) {
      this._messagingRepositry.groups.listen((messaging) {
        add(_ChatGroupListViewInitializeEvent(
          messaging: messaging,
        ));
      });
    } else if (event is _ChatGroupListViewInitializeEvent) {
      yield ChatGroupListViewInitialState(
        messaging: event.messaging,
      );
    }
  }
}
