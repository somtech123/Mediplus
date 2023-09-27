import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/services/chat/model/chat_message_model.dart';

class LastDateContainer extends StatelessWidget {
  final stream;

  LastDateContainer({
    @required this.stream,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.hasData) {
          var docList = snapshot.data!.docs;

          if (docList.isNotEmpty) {
            ChatMessageModel2 message =
                ChatMessageModel2.fromMap(docList.last.data());
            return Text(
              DateFormat.yMMMMd().format(message.timestamp!.toDate()),
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColor.greyColor,
                fontSize: 12,
              ),
            );
          }

          return const Text(
            "No Message",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          );
        }
        return const Text(
          "..",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        );
      },
    );
  }
}
