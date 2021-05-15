import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/messaging.dart';
import 'package:chat/repositories/models/message_model.dart';
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
      List<MessageModel> messages =
          await _messagingRepository.messagesbyGroupId(event.chatId).first;

      yield ChatListViewInitialState(
        messages: messages,
      );
    }
  }
}
