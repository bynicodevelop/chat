part of 'chat_message_form_bloc.dart';

abstract class ChatMessageFormState extends Equatable {
  const ChatMessageFormState();

  @override
  List<Object> get props => [];
}

class ChatMessageFormInitialState extends ChatMessageFormState {}

class ChatMessageFormChatingState extends ChatMessageFormState {}

class ChatMessageFormSentState extends ChatMessageFormState {}
