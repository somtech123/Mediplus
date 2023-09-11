import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../features/onboarding/screen/onboarding.dart';
import 'model/user_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> register(UserModel payload, String password) async {
    String res = "Some error occurred";

    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: payload.email!, password: password);

      await _createFireStoreUser(payload, cred.user!.uid);

      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        res = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      } else {
        res = e.code;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<void> _createFireStoreUser(UserModel payload, String uid) async {
    await _firestore.collection("users").doc(uid).set({
      "userName": payload.userName,
      "id": uid,
      "profileImage": payload.profileImage,
      "firstName": payload.firstName,
      "lastName": payload.lastName,
      "gender": payload.gender,
      "country": payload.country,
      "phone": payload.phone,
      "email": payload.email,
      "bio": payload.bio,
      'state': payload.state,
      "birthDate": payload.birthDate!.toIso8601String(),
      "dateCreated": DateTime.now().toIso8601String(),
    });
  }

  Future<void> _createFireStoreUserwithCredential(UserCredential cred) async {
    await _firestore.collection("users").doc(cred.user!.uid).set({
      "userName": cred.user!.displayName,
      "id": cred.user!.uid,
      "profileImage": cred.user!.photoURL,
      "firstName": '',
      "lastName": '',
      "gender": '',
      "country": '',
      "phone": cred.user!.phoneNumber,
      "email": cred.user!.email,
      "bio": '',
      'state': '',
      "birthDate": '',
      "dateCreated": DateTime.now().toIso8601String(),
    });
  }

  Future<String> loginUser(String password, String email) async {
    String res = "Some error occurred";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res = 'Wrong password provided for that user.';
      } else {
        res = e.code;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<String> resetPassword(String email) async {
    String res = "Some error occurred";
    try {
      await _auth.sendPasswordResetEmail(email: email);
      res = 'success';
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<UserCredential?> _getGooglecredential() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    // obtain auth detail from request
    if (gUser != null) {
      final GoogleSignInAuthentication gauth = await gUser.authentication;
      final AuthCredential cred = GoogleAuthProvider.credential(
          accessToken: gauth.accessToken, idToken: gauth.idToken);
      return await _auth.signInWithCredential(cred);
    }

    return null;
  }

  Future<UserCredential> _getFacebookCredential() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<String> signInWithFacebook() async {
    String res = "Some error occurred";
    try {
      UserCredential userCredential = await _getFacebookCredential();
      if (userCredential != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          _createFireStoreUserwithCredential(userCredential);
          res = 'success';
        }
        res = 'success';
      }
    } catch (e) {}
    return res;
  }

  Future<String> signInWithGoogle() async {
    String res = "Some error occurred";
    try {
      UserCredential? userCredential = await _getGooglecredential();
      if (userCredential != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          _createFireStoreUserwithCredential(userCredential);
          res = 'success';
        }
        res = 'success';
      }
    } on FirebaseAuthException catch (e) {
      res = e.code;
    } catch (e) {
      debugPrint(e.toString());
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    Get.offAllNamed(OnboardingScreen.path);
  }
}
