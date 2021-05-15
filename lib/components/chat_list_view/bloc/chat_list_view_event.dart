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
