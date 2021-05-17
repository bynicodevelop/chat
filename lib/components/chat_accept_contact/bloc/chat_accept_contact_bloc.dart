import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat/repositories/abstracts/messaging.dart';
import 'package:equatable/equatable.dart';

part 'chat_accept_contact_event.dart';
part 'chat_accept_contact_state.dart';

class ChatAcceptContactBloc
    extends Bloc<ChatAcceptContactEvent, ChatAcceptContactState> {
  MessagingRepository _messagingRepository;

  ChatAcceptContactBloc(
    this._messagingRepository,
  ) : super(ChatAcceptContactInitialState());

  @override
  Stream<ChatAcceptContactState> mapEventToState(
    ChatAcceptContactEvent event,
  ) async* {
    if (event is ChatAcceptContactAcceptedEvent) {
      await _messagingRepository.accpectMessaging(event.groupId);

      yield ChatAcceptContactInitialState(
        chatAcceptContactStatus: ChatAcceptContactStatus.accepted,
      );
    } else if (event is ChatAcceptContactRefusedEvent) {
      await _messagingRepository.refuseMessaging(event.groupId);

      yield ChatAcceptContactInitialState(
        chatAcceptContactStatus: ChatAcceptContactStatus.refuses,
      );
    }
  }
}
