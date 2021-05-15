part of 'chat_group_list_view_bloc.dart';

abstract class ChatGroupListViewEvent extends Equatable {
  const ChatGroupListViewEvent();

  @override
  List<Object> get props => [];
}

class ChatGroupListViewInitializeEvent extends ChatGroupListViewEvent {
  final String? channelSelected;

  ChatGroupListViewInitializeEvent({
    this.channelSelected,
  });
}

class _ChatGroupListViewInitializeEvent extends ChatGroupListViewEvent {
  final List<GroupModel> messaging;

  _ChatGroupListViewInitializeEvent({
    this.messaging = const <GroupModel>[],
  });
}
