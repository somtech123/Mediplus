import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../authentication/model/user_model.dart';

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    try {
      User currentUser = _auth.currentUser!;
      debugPrint(
          '=====================${_auth.currentUser!.uid}===================');
      DocumentSnapshot<Map<String, dynamic>> snap =
          await _firestore.collection("users").doc(currentUser.uid).get();
      debugPrint('===================${snap.data()}================');
      return UserModel.fromJson(snap.data()!);
    } catch (e) {
      debugPrint(e.toString());
      debugPrint('-------------empty data------------');
      return UserModel();
    }
  }

  Future<String> updateUserProfile(UserModel payload) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection("users").doc(_auth.currentUser!.uid).update({
        "userName": payload.userName,
        "firstName": payload.firstName,
        "lastName": payload.lastName,
        "gender": payload.gender,
        "country": payload.country,
        "phone": payload.phone,
        "bio": payload.bio,
        'state': payload.state,
        "birthDate": payload.birthDate!.toIso8601String(),
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
      debugPrint(e.toString());
    }
    return res;
  }
}
