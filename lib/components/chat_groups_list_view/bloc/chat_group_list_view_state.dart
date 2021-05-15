part of 'chat_group_list_view_bloc.dart';

abstract class ChatGroupListViewState extends Equatable {
  const ChatGroupListViewState();

  @override
  List<Object> get props => [];
}

class ChatGroupListViewInitialState extends ChatGroupListViewState {
  final List<GroupModel> messaging;

  ChatGroupListViewInitialState({
    this.messaging = const <GroupModel>[],
  });

  @override
  List<Object> get props => [messaging];
}
