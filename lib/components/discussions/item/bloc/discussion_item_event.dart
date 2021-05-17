part of 'discussion_item_bloc.dart';

abstract class DiscussionItemEvent extends Equatable {
  const DiscussionItemEvent();

  @override
  List<Object> get props => [];
}

class DiscussionItemSelectedEvent extends DiscussionItemEvent {
  final GroupModel groupModelSelected;

  DiscussionItemSelectedEvent({
    required this.groupModelSelected,
  });
}
