part of 'discussion_bloc.dart';

abstract class DiscussionEvent extends Equatable {
  const DiscussionEvent();

  @override
  List<Object> get props => [];
}

class DiscussionInitializedEvent extends DiscussionEvent {
  final List<GroupModel> discussions;
  final String status;

  DiscussionInitializedEvent({
    required this.discussions,
    required this.status,
  });
}
