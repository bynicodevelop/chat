import 'package:chat/repositories/models/profile_model.dart';

class MessageModel {
  final String messageId;
  final String content;
  final String sentBy;
  final int sentAt;
  final bool isMe;
  final ProfileModel profileModel;

  MessageModel({
    required this.messageId,
    required this.content,
    required this.sentBy,
    required this.sentAt,
    required this.isMe,
    required this.profileModel,
  });
}
