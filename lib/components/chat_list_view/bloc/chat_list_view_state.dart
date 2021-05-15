part of 'chat_list_view_bloc.dart';

abstract class ChatListViewState extends Equatable {
  const ChatListViewState();

  @override
  List<Object> get props => [];
}

class ChatListViewInitialState extends ChatListViewState {
  final List<MessageModel> messages;

  ChatListViewInitialState({
    this.messages = const <MessageModel>[],
  });

  @override
  List<Object> get props => [messages];
}
