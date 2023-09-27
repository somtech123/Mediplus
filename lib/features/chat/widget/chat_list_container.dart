import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/chat/widget/chat_list_tile.dart';
import 'package:mediplus/features/chat/widget/quit_box.dart';

import '../../../core/gloalctr.dart';
import '../../../core/services/chat/model/contact.dart';
import '../../../core/services/chat/usecase.dart';
import '../../../core/utlis/shimmer_manager.dart';

// ignore: must_be_immutable
class ChatContainer extends StatelessWidget {
  ChatContainer({super.key});

  final ChatMethods _chatMethods = ChatMethods();

  var globalCtr = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chatMethods.fetchContacts(
          userId: globalCtr.user.value.id.toString()),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          var docList = snapshot.data!.docs;

          if (docList.isEmpty) {
            return QuietBox();
          } else {
            return ListView.builder(
                itemCount: docList.length,
                itemBuilder: (BuildContext context, int index) {
                  Contact _contact = Contact.fromMap(docList[index].data());

                  return ChatTile(contact: _contact);
                });
          }
        } else if (snapshot.hasError) {
          return const Center(child: Text('Could not get chats at the moment'));
        }
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ShimmerManager.textShimmer(context));
      },
    );
  }
}
