import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:mediplus/core/services/user/model/doctor_model.dart';

import '../authentication/model/user_model.dart';

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserDetails() async {
    try {
      User currentUser = _auth.currentUser!;
      DocumentSnapshot<Map<String, dynamic>> snap =
          await _firestore.collection("users").doc(currentUser.uid).get();
      return UserModel.fromJson(snap.data()!);
    } catch (e) {
      debugPrint(e.toString());

      return UserModel();
    }
  }

  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      final snap = await _firestore.collection("doctor").get();
      final userdata = snap.docs
          .map((DocumentSnapshot<Map<String, dynamic>> e) =>
              DoctorModel.fromJson(e.data()!))
          .toList();
      return userdata;
    } catch (e) {
      return [];
    }
  }

  Future<List<DoctorModel>> searchDoctor(String query) async {
    var snap = await _firestore
        .collection('doctor')
        .where('firstName', isGreaterThanOrEqualTo: query)
        .where('firstName', isLessThan: query + 'z')
        .get();
    final userdata = snap.docs
        .map((DocumentSnapshot<Map<String, dynamic>> e) =>
            DoctorModel.fromJson(e.data()!))
        .toList();
    debugPrint(userdata.toString());
    return userdata;
    // return tb;
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

  Future<String> bookAppointment() async {
    String res = "Some error occurred";
    try {} catch (e) {}
    return res;
  }
}
