part of 'chat_message_form_bloc.dart';

abstract class ChatMessageFormEvent extends Equatable {
  const ChatMessageFormEvent();

  @override
  List<Object> get props => [];
}

class ChatChatMessageEvent extends ChatMessageFormEvent {
  final String content;
  final String chatId;

  ChatChatMessageEvent({
    required this.content,
    required this.chatId,
  });
}
