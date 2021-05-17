part of 'chat_accept_contact_bloc.dart';

abstract class ChatAcceptContactEvent extends Equatable {
  const ChatAcceptContactEvent();

  @override
  List<Object> get props => [];
}

class ChatAcceptContactAcceptedEvent extends ChatAcceptContactEvent {
  final String groupId;

  ChatAcceptContactAcceptedEvent({
    required this.groupId,
  });
}

class ChatAcceptContactRefusedEvent extends ChatAcceptContactEvent {
  final String groupId;

  ChatAcceptContactRefusedEvent({
    required this.groupId,
  });
}
