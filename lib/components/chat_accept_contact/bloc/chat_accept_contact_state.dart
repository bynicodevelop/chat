part of 'chat_accept_contact_bloc.dart';

enum ChatAcceptContactStatus { none, accepted, refuses }

abstract class ChatAcceptContactState extends Equatable {
  const ChatAcceptContactState();

  @override
  List<Object> get props => [];
}

class ChatAcceptContactInitialState extends ChatAcceptContactState {
  final ChatAcceptContactStatus chatAcceptContactStatus;

  ChatAcceptContactInitialState({
    this.chatAcceptContactStatus = ChatAcceptContactStatus.none,
  });

  @override
  List<Object> get props => [chatAcceptContactStatus];
}
