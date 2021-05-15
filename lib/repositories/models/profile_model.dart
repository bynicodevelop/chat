class ProfileModel {
  final String uid;
  final String photoURL;
  final String displayName;

  final String? email;

  ProfileModel({
    required this.uid,
    required this.photoURL,
    required this.displayName,
    this.email,
  });

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "photoURL": photoURL,
        "displayName": displayName,
        "email": email,
      };
}
