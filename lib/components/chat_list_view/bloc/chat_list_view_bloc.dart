import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/messaging.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:chat/repositories/models/message_model.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:equatable/equatable.dart';

part 'chat_list_view_event.dart';
part 'chat_list_view_state.dart';

class ChatListViewBloc extends Bloc<ChatListViewEvent, ChatListViewState> {
  final MessagingRepository _messagingRepository;

  ChatListViewBloc(
    this._messagingRepository,
  ) : super(ChatListViewInitialState());

  @override
  Stream<ChatListViewState> mapEventToState(
    ChatListViewEvent event,
  ) async* {
    if (event is ChatListViewInitializeEvent) {
      _messagingRepository.messagesbyGroupId(event.groupModel.channelId).listen(
        (messages) {
          add(_ChatListViewInitializeEvent(
              messages: messages, groupModel: event.groupModel));
        },
      );
    } else if (event is _ChatListViewInitializeEvent) {
      yield ChatListViewInitialState(
        messages: event.messages,
        members: event.groupModel.members,
        groupId: event.groupModel.channelId,
        status: event.groupModel.status,
        isFirstContact: event.groupModel.isFirstContact,
      );
    }
  }
}
