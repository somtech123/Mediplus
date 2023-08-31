import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
      "country": payload.gender,
      "phone": payload.phone,
      "email": payload.email,
      "bio": payload.bio,
      'state': payload.state,
      "birthDate": payload.birthDate!.toIso8601String(),
      "dateCreated": DateTime.now().toIso8601String(),
    });
  }
}
