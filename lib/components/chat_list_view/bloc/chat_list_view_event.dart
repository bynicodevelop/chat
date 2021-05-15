part of 'chat_list_view_bloc.dart';

abstract class ChatListViewEvent extends Equatable {
  const ChatListViewEvent();

  @override
  List<Object> get props => [];
}

class ChatListViewInitializeEvent extends ChatListViewEvent {
  final String chatId;

  ChatListViewInitializeEvent({
    required this.chatId,
  });
}
