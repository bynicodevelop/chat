import 'dart:async';

import 'package:chat/repositories/abstracts/messaging.dart';
import 'package:chat/repositories/models/message_model.dart';
import 'package:chat/repositories/models/group_model.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessagingImplRepository extends MessagingRepository {
  static const String GROUPS = "groups";
  static const String MESSAGES = "messages";
  static const String USERS = "users";

  FirebaseAuth _auth;
  FirebaseFirestore _firestore;

  final List<GroupModel> groupModels = <GroupModel>[];

  MessagingImplRepository(
    this._auth,
    this._firestore,
  );

  @override
  Stream<List<GroupModel>> get groups => _firestore
          .collection(GROUPS)
          .orderBy(
            "recentMessage.updatedAt",
            descending: true,
          )
          .where(
            "members",
            arrayContains: _auth.currentUser!.uid,
          )
          .snapshots()
          .asyncMap(
        (group) {
          return Future.wait(group.docs.map(
            (e) async {
              DocumentSnapshot userDocumentSnapshot = await _firestore
                  .collection(USERS)
                  .doc(e.data()["recentMessage"]["sendBy"])
                  .get();
              return GroupModel(
                channelId: e.id,
                avatar: userDocumentSnapshot.get("photoURL"),
                username: userDocumentSnapshot.get("displayName"),
                content: e.data()["recentMessage"]["content"],
                lastUpdated: e.data()["recentMessage"]["updatedAt"],
              );
            },
          ));
        },
      );

  @override
  Stream<List<MessageModel>> messagesbyGroupId(String groupId) {
    Map<String, ProfileModel> profileModels = <String, ProfileModel>{};

    return _firestore
        .collection(GROUPS)
        .doc(groupId)
        .collection(MESSAGES)
        .orderBy("sentAt")
        .snapshots()
        .asyncMap(
      (messages) async {
        return Future.wait(messages.docs.map((message) async {
          if (!profileModels.containsKey(message.data()["sendBy"])) {
            DocumentSnapshot userDocumentSnapshot = await _firestore
                .collection(USERS)
                .doc(message.data()["sendBy"])
                .get();

            profileModels.putIfAbsent(
                message.data()["sendBy"],
                () => ProfileModel(
                    uid: userDocumentSnapshot.id,
                    photoURL: userDocumentSnapshot.get("photoURL") as String,
                    displayName: userDocumentSnapshot.get("displayName")));
          }

          return MessageModel(
              messageId: message.id,
              content: message.data()["content"],
              sentBy: message.data()["sendBy"],
              sentAt: message.data()["sentAt"],
              isMe: _auth.currentUser!.uid == message.data()["sendBy"],
              profileModel: profileModels[message.data()["sendBy"]]!);
        }).toList());
      },
    );
  }

  @override
  Future<void> sendMessage(String content, String chatId) async {
    await _firestore.collection(GROUPS).doc(chatId).collection(MESSAGES).add({
      "content": content,
      "sendBy": _auth.currentUser!.uid,
      "sentAt": DateTime.now().millisecondsSinceEpoch,
    });
  }
}
