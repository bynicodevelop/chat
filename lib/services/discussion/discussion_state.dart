part of 'discussion_bloc.dart';

abstract class DiscussionState extends Equatable {
  const DiscussionState();

  @override
  List<Object> get props => [];
}

class DiscussionInitialState extends DiscussionState {
  final GroupModel? discussion;
  final String status;

  DiscussionInitialState({
    this.status = "",
    this.discussion,
  });

  @override
  List<Object> get props => [status];
}
