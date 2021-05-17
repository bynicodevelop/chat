part of 'chat_list_view_bloc.dart';

abstract class ChatListViewState extends Equatable {
  const ChatListViewState();

  @override
  List<Object> get props => [];
}

class ChatListViewInitialState extends ChatListViewState {
  final List<MessageModel> messages;
  final List<ProfileModel> members;
  final String groupId;
  final String status;
  final bool isFirstContact;

  ChatListViewInitialState({
    this.messages = const <MessageModel>[],
    this.members = const <ProfileModel>[],
    this.groupId = "",
    this.status = "accepted",
    this.isFirstContact = false,
  });

  @override
  List<Object> get props => [
        messages,
        members,
        groupId,
        status,
        isFirstContact,
      ];
}
