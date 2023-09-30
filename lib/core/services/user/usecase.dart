import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:mediplus/core/services/user/model/appointment_model.dart';
import 'package:mediplus/core/services/user/model/doctor_model.dart';
import 'package:mediplus/core/services/user/model/favourite_model.dart';
import 'package:mediplus/env/private_key.dart';

import '../authentication/model/user_model.dart';
import '../chat/model/chat_user_model.dart';
import '../strorage_method.dart';
import 'model/service_model.dart';

class UserServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference _userCollection = _firestore.collection("users");

  final CollectionReference _docCollection = _firestore.collection("doctor");
  static final FirebaseDatabase _db = FirebaseDatabase.instance;

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

  Future<ChatUserModel> getUserDetailsById(id) async {
    debugPrint("getting user from firebase $id");
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection("doctor").doc(id).get();
      debugPrint("getting document from firebase ${documentSnapshot.data()!}");
      var user = ChatUserModel.fromMap(documentSnapshot.data()!);
      debugPrint('user from firebade is============== ${user.userId}');
      return user;
    } catch (e) {
      debugPrint("$e");
      return ChatUserModel();
    }
  }

  Stream<UserModel> getProfilePhoto({String? id}) {
    StreamController<UserModel> controller = StreamController<UserModel>();

    _firestore.collection("users").doc(id).snapshots().listen((event) {
      if (event.exists) {
        var user = UserModel.fromJson(event.data()!);
        controller.add(user);
      } else {
        controller.addError("User not found");
      }
    });

    return controller.stream;
  }

  // Stream<UserModel> getProfilePhoto({String? id}) async* {
  //   DocumentSnapshot<Map<String, dynamic>> ref =
  //       await _firestore.collection("users").doc(id).get();
  //   var user = UserModel.fromJson(ref.data()!);

  //   yield user;
  // }

  Future<DoctorModel> getDoctorById(id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await _firestore.collection("doctor").doc(id).get();
      var user = DoctorModel.fromJson(documentSnapshot.data()!);
      return user;
    } catch (e) {
      debugPrint("$e");
      return DoctorModel();
    }
  }

  Future<ServiceChargeModel> getServiceCharge() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snap =
          await _firestore.collection('mediplus').doc(PrivateKey.docId).get();
      return ServiceChargeModel.fromJson(snap.data()!);
    } catch (e) {}
    return ServiceChargeModel();
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

  Future<String> updateProfilePhoto(File file) async {
    String res = '';
    try {
      if (file != null) {
        String photo = await StorageMethod().updateProfile(file);
        await _firestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .update({'profileImage': photo});
        res = 'success';
      } else {
        res = 'no photo selected';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<List<String>> uploadFiles(List<File> file) async {
    var fileUrls = await Future.wait(
        file.map((data) => StorageMethod().uploadFiles(data)));
    return fileUrls;
  }

  DocumentReference getFavouriteDocument({String? of, String? forContact}) =>
      _userCollection.doc(of).collection('favourite').doc(forContact);

  Stream<DocumentSnapshot> fetchFavourite(
      {String? userId, String? receiverId}) {
    final docReference =
        _userCollection.doc(userId).collection('favourite').doc(receiverId);
    return docReference.snapshots().map((snapshot) {
      if (snapshot.exists) {
        return snapshot;
      } else {
        FavouriteModel _favourite = FavouriteModel(
            isfavourite: false,
            receiverID: receiverId,
            addedOn: Timestamp.now());

        var payload = _favourite.toMap(_favourite);
        docReference.set(payload);
        return snapshot;
      }
    });
  }

  toogleFavourite(
      {String? userId, String? receiverId, bool? isFavourite}) async {
    FavouriteModel _favourite = FavouriteModel(
        isfavourite: isFavourite,
        receiverID: receiverId,
        addedOn: Timestamp.now());

    var payload = _favourite.toMap(_favourite);
    await getFavouriteDocument(of: userId, forContact: receiverId).set(payload);
  }

  Future<void> checkFavourite({
    required String senderId,
    required String receiverId,
  }) async {
    DocumentSnapshot snapshot =
        await getFavouriteDocument(of: senderId, forContact: receiverId).get();
    if (!snapshot.exists) {
      //does not exits
      FavouriteModel _favourite = FavouriteModel(
          isfavourite: false, receiverID: receiverId, addedOn: Timestamp.now());

      var payload = _favourite.toMap(_favourite);

      await getFavouriteDocument(of: senderId, forContact: receiverId)
          .set(payload);
    }
  }

  Stream<QuerySnapshot> fetchallFavourite({String? userId}) => _userCollection
      .doc(userId)
      .collection('favourite')
      .where('isFvourite', isEqualTo: true)
      .snapshots();

  Future<List<AppointmentModel>> getAppointmentHistory() async {
    List<AppointmentModel> userData = [];
    try {
      var snap = await _db
          .ref()
          .child('appointments')
          .child(_auth.currentUser!.uid)
          .orderByChild('date_created')
          .once();

      if (snap.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            (snap.snapshot.value as Map<dynamic, dynamic>);

        debugPrint(data.toString());

        List<MapEntry<dynamic, dynamic>> sortedEntries = data.entries.toList()
          ..sort((a, b) {
            var timestampA = a.value['date_created'];
            var timestampB = b.value['date_created'];
            return timestampB.compareTo(timestampA);
          });

        for (var entry in sortedEntries) {
          var appointment = AppointmentModel.fromJson(entry.value);
          userData.add(appointment);
        }
      }
    } catch (e) {
      debugPrint('Error fetching appointment history: $e');
    }
    return userData;
  }

  Future<List<AppointmentModel>> sortAppointmentBySatus(
      {required String status}) async {
    List<AppointmentModel> userData = [];
    try {
      var snap = await _db
          .ref()
          .child('appointments')
          .child(_auth.currentUser!.uid)
          .orderByChild('status')
          .equalTo(status)
          .once();

      if (snap.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            (snap.snapshot.value as Map<dynamic, dynamic>);
        debugPrint(data.toString());

        List<MapEntry<dynamic, dynamic>> sortedEntries = data.entries.toList()
          ..sort((a, b) {
            var timestampA = a.value['date_created'];
            var timestampB = b.value['date_created'];
            return timestampB.compareTo(timestampA);
          });

        for (var entry in sortedEntries) {
          var appointment = AppointmentModel.fromJson(entry.value);
          userData.add(appointment);
        }
      }
    } catch (e) {
      debugPrint('Error fetching completed appointments: $e');
    }
    return userData;
  }

  Future<List<AppointmentModel>> upComingAppointments() async {
    List<AppointmentModel> userData = [];
    try {
      var snap = await _db
          .ref()
          .child('appointments')
          .child(_auth.currentUser!.uid)
          .orderByChild('status')
          .startAt('completed' + '\uf8ff')

          // .orderByChild('status')
          // .equalTo('completed')
          .once();

      if (snap.snapshot.value != null) {
        Map<dynamic, dynamic> data =
            (snap.snapshot.value as Map<dynamic, dynamic>);
        debugPrint(data.toString());

        List<MapEntry<dynamic, dynamic>> sortedEntries = data.entries.toList()
          ..sort((a, b) {
            var timestampA = a.value['date_created'];
            var timestampB = b.value['date_created'];
            return timestampB.compareTo(timestampA);
          });

        for (var entry in sortedEntries) {
          var appointment = AppointmentModel.fromJson(entry.value);
          userData.add(appointment);
        }
      }
    } catch (e) {
      debugPrint('Error fetching completed appointments: $e');
    }
    return userData;
  }

  DocumentReference getReviewDocument({String? of, String? by}) =>
      _docCollection.doc(of).collection('review').doc(by);

  Future<String> sendReview(
      {String? docId,
      String? userId,
      required Map<String, dynamic> payload}) async {
    String res = "Some error occurred";
    try {
      await getReviewDocument(of: docId, by: userId)
          .set(payload, SetOptions(merge: true));
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Stream<QuerySnapshot> fetchDoctorReview({String? docId}) =>
      _docCollection.doc(docId).collection('review').snapshots();
}
