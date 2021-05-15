part of 'chat_groups_item_bloc.dart';

abstract class ChatGroupsItemState extends Equatable {
  const ChatGroupsItemState();

  @override
  List<Object> get props => [];
}

class ChatGroupsItemInitialState extends ChatGroupsItemState {
  final String itemSelected;

  ChatGroupsItemInitialState({
    this.itemSelected = "",
  });

  @override
  List<Object> get props => [itemSelected];
}
