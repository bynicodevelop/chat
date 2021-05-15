import 'dart:io';
import 'dart:typed_data';

import 'package:chat/repositories/abstracts/profile.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileImplRepository extends ProfileRepository {
  static const String USERS = "users";

  FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firestore;
  FirebaseFunctions _functions;
  FirebaseStorage _storage;

  ProfileImplRepository(
    this._firebaseAuth,
    this._firestore,
    this._functions,
    this._storage,
  );

  @override
  Future<ProfileModel> get profile async {
    DocumentSnapshot documentSnapshot = await _firestore
        .collection(USERS)
        .doc(_firebaseAuth.currentUser!.uid)
        .get();

    return ProfileModel(
      uid: documentSnapshot.id,
      photoURL: documentSnapshot.get("photoURL") ?? "",
      displayName: documentSnapshot.get("displayName") ?? "",
      email: documentSnapshot.get("email"),
    );
  }

  @override
  Future updateProfile(ProfileModel profileModel) async => await _functions
      .httpsCallable('updateProfile')
      .call(profileModel.toJson());

  @override
  Future<String> updatePhotoURL({
    Uint8List? data,
    String? path,
  }) async {
    String downloadedData = "";

    Reference ref = _storage.ref("uploads/avatar.jpg");

    try {
      if (data != null) {
        await ref.putData(data);
      } else {
        await ref.putFile(File(path!));
      }

      downloadedData = await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      print(e);
    }

    return downloadedData;
  }
}
