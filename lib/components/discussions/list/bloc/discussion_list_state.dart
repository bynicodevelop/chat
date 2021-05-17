part of 'discussion_list_bloc.dart';

abstract class DiscussionListState extends Equatable {
  const DiscussionListState();

  @override
  List<Object> get props => [];
}

class DiscussionListInitialState extends DiscussionListState {
  final List<GroupModel> discussions;

  DiscussionListInitialState({
    this.discussions = const <GroupModel>[],
  });

  @override
  List<Object> get props => [discussions];
}
