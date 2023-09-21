import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethod {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadToStorage(
      {required String fileName, required Uint8List file}) async {
    String res = "Some error occurred";
    String imageUrl = '';
    try {
      Reference ref = _storage.ref().child(_auth.currentUser!.uid);

      UploadTask uploadTask = ref.putData(file);
      res = 'success';

      TaskSnapshot snap = await uploadTask;

      imageUrl = await snap.ref.getDownloadURL();
    } on FirebaseException catch (e) {
      res = e.code;
    } catch (e) {
      debugPrint(e.toString());
    }
    return imageUrl;
  }

  Future<String> uploadFiles(File file) async {
    String imageUrl = '';
    try {
      Reference ref = _storage
          .ref()
          .child('report/${_auth.currentUser!.uid}')
          .child(_auth.currentUser!.uid);

      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snap = await uploadTask;

      imageUrl = await snap.ref.getDownloadURL();
    } catch (e) {}
    return imageUrl;
  }
}
