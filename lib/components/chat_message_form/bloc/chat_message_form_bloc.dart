import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/messaging.dart';
import 'package:equatable/equatable.dart';

part 'chat_message_form_event.dart';
part 'chat_message_form_state.dart';

class ChatMessageFormBloc
    extends Bloc<ChatMessageFormEvent, ChatMessageFormState> {
  MessagingRepository _messagingRepository;

  ChatMessageFormBloc(
    this._messagingRepository,
  ) : super(ChatMessageFormInitialState());

  @override
  Stream<ChatMessageFormState> mapEventToState(
    ChatMessageFormEvent event,
  ) async* {
    if (event is ChatChatMessageEvent) {
      yield ChatMessageFormChatingState();

      await _messagingRepository.sendMessage(
        event.content,
        event.chatId,
      );

      yield ChatMessageFormSentState();
    }
  }
}
