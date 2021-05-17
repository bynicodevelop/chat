part of 'discussion_item_bloc.dart';

abstract class DiscussionItemState extends Equatable {
  const DiscussionItemState();

  @override
  List<Object> get props => [];
}

class DiscussionItemInitialState extends DiscussionItemState {
  final String itemSelected;

  DiscussionItemInitialState({
    this.itemSelected = "",
  });

  @override
  List<Object> get props => [itemSelected];
}
