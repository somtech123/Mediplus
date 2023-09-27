import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../core/gloalctr.dart';
import '../../../core/services/chat/model/chat_message_model.dart';
import '../../../core/services/chat/model/chat_user_model.dart';
import '../../../core/services/chat/usecase.dart';
import '../widget/chat_appbar.dart';

class ViewLayout extends StatefulWidget {
  const ViewLayout({super.key, required this.receiver});
  final ChatUserModel receiver;

  @override
  State<ViewLayout> createState() => _ViewLayoutState();
}

class _ViewLayoutState extends State<ViewLayout> {
  ChatUser? user;

  ChatUser? receiver;

  final ChatMethods _chatMethods = ChatMethods();

  FocusNode textFieldFocus = FocusNode();

  var messageController = TextEditingController();

  bool isWriting = false;
  bool show = false;

  var globalCtr = Get.find<GlobalController>();

  List<ChatMessage> messages = [];

  showKeyboard() => textFieldFocus.requestFocus();

  hideKeyboard() => textFieldFocus.unfocus();
  fetchMessages() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('messages')
        .doc(globalCtr.user.value.id.toString())
        .collection(widget.receiver.userId!)
        .orderBy('timestamp', descending: false)
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != globalCtr.user.value.id.toString()) {
        var res = ChatMessageModel2.fromMap(querySnapshot.docs[i].data());
        debugPrint(" sender id is ${res.senderId}");

        var incomingMessage = ChatMessage(
            user: res.senderId == globalCtr.user.value.id ? user! : receiver!,
            createdAt: res.timestamp!.toDate(),
            text: res.message!);
        debugPrint(
            "${globalCtr.user.value.id} message is ${incomingMessage.toJson().toString()}");

        messages.insert(0, incomingMessage);
      }
    }

    setState(() {});
  }

  setUser() {
    debugPrint(
        "my id is ${globalCtr.user.value.id} while your id is ${widget.receiver.userId!}");
    user = ChatUser(
        id: globalCtr.user.value.id!,
        firstName: globalCtr.user.value.firstName!,
        lastName: globalCtr.user.value.lastName,
        profileImage: globalCtr.user.value.profileImage,
        customProperties: {"userName": globalCtr.user.value.userName});

    receiver = ChatUser(
        id: widget.receiver.userId!,
        profileImage: widget.receiver.profileUrl,
        firstName: widget.receiver.firstname,
        lastName: widget.receiver.lastname,
        customProperties: {"userName": widget.receiver.userName});

    debugPrint("my sender is ${user!.toJson().toString()}");

    debugPrint("my receiver is ${receiver!.toJson().toString()}");

    setState(() {});
  }

  @override
  void initState() {
    setUser();
    fetchMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(
        user: widget.receiver,
      ),
      body: Stack(
        children: [
          DashChat(
            currentUser: user!,
            onSend: (ChatMessage m) {
              sendMessage(m);
            },
            messages: messages,
            inputOptions: InputOptions(
                leading: const [Icon(Icons.emoji_emotions, color: Colors.grey)],
                trailing: [SvgPicture.asset("assets/svgs/attachment.svg")],
                inputToolbarStyle: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                  10,
                ))),
            messageOptions: MessageOptions(
              showTime: true,
            ),
            messageListOptions: MessageListOptions(),
          ),
          messages.isEmpty ? noMessages(context) : SizedBox()
        ],
      ),
    );
  }

  Widget noMessages(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'No messages here yet...',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
          ),
          Text(
            'Start a conversation and share events together.',
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          )
        ],
      ),
    );
  }

  void sendMessage(ChatMessage m) async {
    debugPrint(m.toJson().toString());

    ChatMessageModel2 _message = ChatMessageModel2(
      senderId: globalCtr.user.value.id,
      receiverId: widget.receiver.userId,
      type: 'text',
      message: m.text,
      timestamp: Timestamp.now(),
    );

    setState(() {
      messageController.text = "";
      isWriting = false;
    });

    var _sender = ChatUserModel(
        firstname: globalCtr.user.value.firstName!,
        lastname: globalCtr.user.value.lastName!,
        userId: globalCtr.user.value.id.toString());

    hideKeyboard();

    messages.insert(0, m);

    debugPrint("My sender model is ${_sender.toJson()}");
    debugPrint("My receiver model is ${widget.receiver.toJson()}");

    await _chatMethods.addMessageToDb2(_message, _sender, widget.receiver);
  }
}
