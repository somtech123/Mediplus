import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/constant/string_constant.dart';
import '../../../core/services/chat/model/chat_user_model.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final ChatUserModel user;

  const ChatAppBar({
    super.key,
    required this.user,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: InkWell(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back,
          color: AppColor.blackColor,
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.call,
            color: AppColor.blackColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.more_vert,
            color: Colors.grey,
          ),
        )
      ],
      centerTitle: false,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              user.profileUrl ?? StringConstants.dummyProfilePicture,
            ),
          ),
          // Container(
          //   height: 40.h,
          //   width: 50.w,
          //   decoration: BoxDecoration(
          //     //  borderRadius: BorderRadius.circular(10),
          //     shape: BoxShape.circle,
          //     image: DecorationImage(
          //       fit: BoxFit.cover,
          //       image: NetworkImage(
          //           user.profileUrl ?? StringConstants.dummyProfilePicture),
          //     ),
          //   ),
          // ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${user.firstname} ${user.lastname}",
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColor.blackColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
