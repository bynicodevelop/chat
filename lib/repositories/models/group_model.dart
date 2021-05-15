class GroupModel {
  final String channelId;
  final String avatar;
  final String username;
  final String content;
  final int lastUpdated;

  bool selected;

  GroupModel({
    required this.channelId,
    required this.avatar,
    required this.username,
    required this.content,
    required this.lastUpdated,
    this.selected = false,
  });

  Map<String, dynamic> toJson() => {
        "channelId": channelId,
        "avatar": avatar,
        "username": username,
        "content": content,
        "lastUpdated": lastUpdated,
      };
}
