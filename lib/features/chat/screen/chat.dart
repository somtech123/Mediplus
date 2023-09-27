import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediplus/features/chat/widget/chat_list_container.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared_widgets/custom_textfield.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        title: const Text(
          "Chat",
          style: TextStyle(color: AppColor.blackColor, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          children: [
            CustomBorderTextField(
              hasBorder: true,
              hintText: "Search",
              prefix: const Icon(
                Icons.search,
                color: AppColor.blackColor,
              ),
              suffix: const Icon(
                Icons.menu,
                color: AppColor.blackColor,
              ),
            ),
            SizedBox(
              height: 25.h,
            ),
            Expanded(
              child: ChatContainer(),
            )
          ],
        ),
      )),
    );
  }
}
