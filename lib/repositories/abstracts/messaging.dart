import 'dart:async';

import 'package:chat/repositories/models/group_model.dart';
import 'package:chat/repositories/models/message_model.dart';

abstract class MessagingRepository {
  Stream<List<GroupModel>> get discussions;

  Stream<List<MessageModel>> messagesbyGroupId(String groupId);

  Future<void> sendMessage(String message, String chatId);

  Future<void> accpectMessaging(String groupId);

  Future<void> refuseMessaging(String groupId);
}
