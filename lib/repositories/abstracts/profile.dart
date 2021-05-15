import 'dart:typed_data';

import 'package:chat/repositories/models/profile_model.dart';

abstract class ProfileRepository {
  Future<ProfileModel> get profile;

  Future updateProfile(ProfileModel profileModel);

  Future<String> updatePhotoURL({
    Uint8List? data,
    String? path,
  });
}
