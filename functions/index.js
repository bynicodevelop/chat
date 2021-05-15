const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { nanoid } = require("nanoid");
const _ = require("lodash");

const populate = require("./populate");

admin.initializeApp();

const COLLECTIONS = {
  USERS: "users",
  GROUPS: "groups",
  MESSAGES: "messages",
  AFFILIATES: "affiliates",
};

const groupRef = admin.firestore().collection(COLLECTIONS.GROUPS);

const userRef = admin.firestore().collection(COLLECTIONS.USERS);

exports.populate = functions.https.onRequest(async (request, response) => {
  populate.users.forEach(async (user) => {
    const { uid, email, password, photoURL, displayName } = user;

    await admin
      .auth()
      .createUser({ uid, email, password, photoURL, displayName });
  });

  const listOfGroups = populate.users
    .map((user) => user.membersId.map((id) => [user.uid, id]))
    .flat();

  populate.groups(listOfGroups.length, 10).forEach(async (groups, index) => {
    const { createdAt, messages } = groups;

    const documentReference = await groupRef.add({
      createdAt,
      members: listOfGroups[index],
      createdBy: listOfGroups[index][0],
    });

    const orderedMessages = messages.sort((a, b) => a["sentAt"] - b["sentAt"]);

    orderedMessages.forEach(async (message) => {
      const { content, sentAt } = message;

      const sendBy = listOfGroups[index]
        .map((x) => ({ x, r: Math.random() }))
        .sort((a, b) => a.r - b.r)
        .map((a) => a.x)
        .slice(0, 1)[0];

      await documentReference
        .collection(COLLECTIONS.MESSAGES)
        .add({ content, sentAt, sendBy });
    });
  });

  return response.json();
});

exports.onUserCreated = functions.auth.user().onCreate(async (user) => {
  await userRef.doc(user.uid).set({
    email: user.email,
    photoURL: user.photoURL,
    displayName: user.displayName,
    affiliateId: nanoid(10),
  });
});

exports.onMessageCreated = functions.firestore
  .document(
    `${COLLECTIONS.GROUPS}/{groupId}/${COLLECTIONS.MESSAGES}/{messageId}`
  )
  .onCreate(async (snap, context) => {
    const { content, sentAt, sendBy } = snap.data();
    const { groupId, messageId } = context.params;

    await groupRef.doc(groupId).update({
      recentMessage: { updatedAt: sentAt, content, messageId, sendBy },
    });
  });

exports.updateProfile = functions.https.onCall(async (data, context) => {
  if (context.auth.uid == null) {
    throw new functions.https.HttpsError("permission-denied");
  }

  const { uid, email, displayName, photoURL } = data;

  let values = {
    email,
  };

  // TODO: Verifier la validité des données
  if (!_.isEmpty(photoURL)) {
    values = { ...values, ...{ photoURL } };
  }

  if (!_.isEmpty(displayName)) {
    values = { ...values, ...{ displayName } };
  }

  try {
    await admin.auth().updateUser(uid, values);

    try {
      await userRef.doc(uid).update({ email, displayName, photoURL });
    } catch (error) {
      console.log("Cannot update user profile collection");
      console.log(error);
      throw new functions.https.HttpsError("unavailable");
    }
  } catch (error) {
    console.log("Cannot update user profile");
    console.log(error);
    throw new functions.https.HttpsError("unavailable");
  }

  return "ok";
});

exports.setSponsor = functions.https.onCall(async (data, context) => {
  if (context.auth.uid == null) {
    throw new functions.https.HttpsError("permission-denied");
  }

  const { affiliateId } = data;

  const sponsor = await userRef
    .where("affiliateId", "==", affiliateId)
    .limit(1)
    .get();

  console.log(sponsor.docs);
  if (sponsor.docs.length == 0) {
    throw new functions.https.HttpsError("not-found");
  }

  try {
    await userRef
      .doc(context.auth.uid)
      .update({ sponsor: sponsor.docs[0].ref });

    await userRef
      .doc(sponsor.docs[0].id)
      .collection(COLLECTIONS.AFFILIATES)
      .doc(context.auth.uid)
      .set({
        userRef: userRef.doc(context.auth.uid),
      });
  } catch (error) {
    console.log("Connot update sponsor affiliate");
    console.log(error);
  }
});
