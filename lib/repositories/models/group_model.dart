import 'package:chat/repositories/models/profile_model.dart';

class GroupModel {
  final String channelId;
  final String avatar;
  final String username;
  final String content;
  final int lastUpdated;
  final List<ProfileModel> members;
  final String status;

  bool selected;
  bool isFirstContact;

  GroupModel({
    required this.channelId,
    required this.avatar,
    required this.username,
    required this.content,
    required this.lastUpdated,
    required this.members,
    required this.status,
    this.selected = false,
    this.isFirstContact = false,
  });

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "avatar": avatar,
        "username": username,
        "content": content,
        "lastUpdated": lastUpdated,
      };
}
