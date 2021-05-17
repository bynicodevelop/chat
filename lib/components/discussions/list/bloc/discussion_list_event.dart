part of 'discussion_list_bloc.dart';

abstract class DiscussionListEvent extends Equatable {
  const DiscussionListEvent();

  @override
  List<Object> get props => [];
}

class DiscussionListInitializeEvent extends DiscussionListEvent {
  final String? channelSelected;

  DiscussionListInitializeEvent({
    this.channelSelected,
  });
}

class _DiscussionListInitializeEvent extends DiscussionListEvent {
  final List<GroupModel> discussions;

  _DiscussionListInitializeEvent({
    this.discussions = const <GroupModel>[],
  });
}
