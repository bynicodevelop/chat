import 'package:chat/repositories/abstracts/authentication.dart';
import 'package:chat/repositories/exceptions/affiliate_id_not_found.dart';
import 'package:chat/repositories/exceptions/invalid_email_exception.dart';
import 'package:chat/repositories/exceptions/invalid_password_exception.dart';
import 'package:chat/repositories/exceptions/unexpected_exception.dart';
import 'package:chat/repositories/exceptions/wrong_password_exception.dart';
import 'package:chat/repositories/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationImplRepository extends AuthenticationRepository {
  static const String USERS = "users";

  FirebaseAuth _firebaseAuth;
  FirebaseFirestore _firestore;
  FirebaseFunctions _functions;

  AuthenticationImplRepository(
    this._firebaseAuth,
    this._firestore,
    this._functions,
  );

  @override
  Future<UserModel?> signin(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel(
        uid: userCredential.user!.uid,
      );
    } on FirebaseAuthException catch (e) {
      print("signin - FirebaseAuthException: $e");

      if (e.code == "wrong-password" || e.code == "user-not-found") {
        throw WrongPasswordException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailException();
      }
    } catch (e) {
      print("signin - UnexpectedException: $e");
      throw UnexpectedException();
    }
  }

  @override
  bool get isAuthenticated => _firebaseAuth.currentUser != null;

  @override
  Future<void> logout() async => _firebaseAuth.signOut();

  @override
  Future<UserModel?> signup(
    String email,
    String password,
    String affiliateId,
  ) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection(USERS)
        .where(
          "affiliateId",
          isEqualTo: affiliateId,
        )
        .limit(1)
        .get();

    if (querySnapshot.docs.length == 0) {
      throw AffiliateIdNotFound();
    }

    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _functions.httpsCallable("setSponsor").call({
        "affiliateId": affiliateId,
      });

      return UserModel(
        uid: userCredential.user!.uid,
      );
    } on FirebaseAuthException catch (e) {
      print("signin - FirebaseAuthException: $e");
      if (e.code == "email-already-in-use") {
      } else if (e.code == "weak-password") {
        throw InvalidPasswordException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailException();
      }
    } catch (e) {
      print("signin - UnexpectedException: $e");
      throw UnexpectedException();
    }
  }

  @override
  Future resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print("resetPassword - FirebaseAuthException: $e");

      if (e.code == "invalid-email") {
        throw InvalidEmailException();
      }
    }
  }
}
