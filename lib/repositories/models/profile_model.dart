import 'package:chat/repositories/models/group_model.dart';

class ProfileModel {
  final String uid;
  final String photoURL;
  final String displayName;
  GroupModel? groupModel;
  bool isSelected;
  bool isMe;
  bool isAsked;

  final String? email;

  ProfileModel({
    required this.uid,
    required this.photoURL,
    required this.displayName,
    this.groupModel,
    this.isSelected = false,
    this.isMe = false,
    this.isAsked = false,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photoURL": photoURL,
        "displayName": displayName,
        "isSelected": isSelected,
        "isMe": isMe,
        "isAsked": isAsked,
        "email": email,
      };
}
