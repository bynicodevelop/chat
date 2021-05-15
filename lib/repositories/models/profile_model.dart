class ProfileModel {
  final String uid;
  final String photoURL;
  final String displayName;
  bool isMe;

  final String? email;

  ProfileModel({
    required this.uid,
    required this.photoURL,
    required this.displayName,
    this.isMe = false,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photoURL": photoURL,
        "displayName": displayName,
        "isMe": isMe,
        "email": email,
      };
}
