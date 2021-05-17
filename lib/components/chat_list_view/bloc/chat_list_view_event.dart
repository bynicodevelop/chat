part of 'chat_list_view_bloc.dart';

abstract class ChatListViewEvent extends Equatable {
  const ChatListViewEvent();

  @override
  List<Object> get props => [];
}

class ChatListViewInitializeEvent extends ChatListViewEvent {
  final GroupModel groupModel;

  ChatListViewInitializeEvent({
    required this.groupModel,
  });
}

class _ChatListViewInitializeEvent extends ChatListViewEvent {
  final List<MessageModel> messages;
  final GroupModel groupModel;

  _ChatListViewInitializeEvent({
    required this.messages,
    required this.groupModel,
  });
}
