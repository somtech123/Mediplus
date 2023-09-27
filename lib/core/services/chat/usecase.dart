import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/services/chat/model/chat_message_model.dart';
import 'package:mediplus/core/services/chat/model/chat_user_model.dart';
import 'package:mediplus/core/services/chat/model/contact.dart';
import 'package:mediplus/core/services/user/usecase.dart';

import '../../shared_widgets/alert_widget.dart';

class ChatMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final UserServices _userServices = UserServices();

  final CollectionReference _userCollection = _firestore.collection("users");

  final CollectionReference _messageCollection =
      _firestore.collection('messages');

  DocumentReference getContactsDocument({String? of, String? forContact}) =>
      _userCollection.doc(of).collection('contacts').doc(forContact);

  Future<void> retrieveUserFromFirebase(ChatUserModel user) async {
    try {
      var res = await _userServices.getUserDetailsById(user.userId);

      debugPrint("result from firebase ${res.toJson().toString()}");

      if (res.userId == null) {
        debugPrint('error');

        showErrorAlertWidget(Get.context!,
            message: 'no user found for this id');
      }
    } catch (e) {
      debugPrint('from catch block');
      debugPrint("$e");
    }
  }

  Future<void> addToSenderContacts(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot senderSnapshot =
        await getContactsDocument(of: senderId, forContact: receiverId).get();

    if (!senderSnapshot.exists) {
      //does not exists
      Contact receiverContact = Contact(
        uid: receiverId,
        addedOn: currentTime,
      );

      var receiverMap = receiverContact.toMap(receiverContact);

      await getContactsDocument(of: senderId, forContact: receiverId)
          .set(receiverMap, SetOptions(merge: true));
    }
  }

  Future<void> addToReceiverContacts(
    String senderId,
    String receiverId,
    currentTime,
  ) async {
    DocumentSnapshot receiverSnapshot =
        await getContactsDocument(of: receiverId, forContact: senderId).get();

    if (!receiverSnapshot.exists) {
      //does not exists
      Contact senderContact = Contact(
        uid: senderId,
        addedOn: currentTime,
      );

      var senderMap = senderContact.toMap(senderContact);

      await getContactsDocument(of: receiverId, forContact: senderId)
          .set(senderMap);
    }
  }

  addToContacts({String? senderId, String? receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await addToSenderContacts(senderId!, receiverId!, currentTime);
    await addToReceiverContacts(senderId, receiverId, currentTime);
  }

  Stream<QuerySnapshot> fetchContacts({String? userId}) =>
      _userCollection.doc(userId).collection('contacts').snapshots();

  Future<void> addMessageToDb(ChatMessageModel message, ChatUserModel sender,
      ChatUserModel receiver) async {
    debugPrint("receiver is ${receiver.toJson()}");

    var map = message.toJson();

    await retrieveUserFromFirebase(receiver);

    await _messageCollection
        .doc(sender.userId)
        .collection(receiver.userId!)
        .add(map);

    await _messageCollection
        .doc(receiver.userId!)
        .collection(sender.userId!)
        .add(map);

    await addToContacts(senderId: sender.userId!, receiverId: receiver.userId!);

    //await notifyUser(receiver, message);
  }

  Future<void> addMessageToDb2(ChatMessageModel2 message, ChatUserModel sender,
      ChatUserModel receiver) async {
    debugPrint("receiver is ${receiver.toJson()}");

    var map = message.toMap();

    await retrieveUserFromFirebase(receiver);

    await _messageCollection
        .doc(sender.userId)
        .collection(receiver.userId!)
        .add(map);

    await _messageCollection
        .doc(receiver.userId!)
        .collection(sender.userId!)
        .add(map);

    await addToContacts(senderId: sender.userId!, receiverId: receiver.userId!);

    // await notifyUser(receiver, message);
  }

  Stream<QuerySnapshot> fetchLastMessageBetween({
    required String senderId,
    required String receiverId,
  }) =>
      _messageCollection
          .doc(senderId)
          .collection(receiverId)
          .orderBy("timestamp")
          .snapshots();
}
