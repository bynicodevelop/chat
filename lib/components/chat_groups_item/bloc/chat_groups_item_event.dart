part of 'chat_groups_item_bloc.dart';

abstract class ChatGroupsItemEvent extends Equatable {
  const ChatGroupsItemEvent();

  @override
  List<Object> get props => [];
}

class ChatGroupsItemSelectedEvent extends ChatGroupsItemEvent {
  final String itemSelected;

  ChatGroupsItemSelectedEvent({
    required this.itemSelected,
  });
}
