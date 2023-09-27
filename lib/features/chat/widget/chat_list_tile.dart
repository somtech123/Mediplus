import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/chat/widget/last_date_container.dart';
import 'package:mediplus/features/chat/widget/last_message_container.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/constant/string_constant.dart';
import '../../../core/gloalctr.dart';
import '../../../core/services/chat/model/chat_user_model.dart';
import '../../../core/services/chat/model/contact.dart';
import '../../../core/services/chat/usecase.dart';
import '../../../core/services/user/usecase.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../screen/view_layout.dart';

class ChatTile extends StatelessWidget {
  ChatTile({super.key, required this.contact});
  final Contact contact;
  final UserServices _userServices = UserServices();

  final ChatMethods _chatMethods = ChatMethods();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ChatUserModel>(
      future: _userServices.getUserDetailsById(contact.uid),
      builder: (context, AsyncSnapshot<ChatUserModel> snapshot) {
        if (snapshot.hasData) {
          ChatUserModel user = snapshot.data!;

          return Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: layout(
              context,
              user: user,
            ),
          );
        } else if (snapshot.hasError) {
          debugPrint('${snapshot.error}');
        }
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: ShimmerManager.textShimmer(context),
        );
      },
    );
  }

  Widget layout(BuildContext context, {required ChatUserModel user}) {
    return Container(
      height: 80.h,
      width: Get.width,
      padding: EdgeInsets.only(left: 15.h),
      decoration: BoxDecoration(
          color: AppColor.greyWithOPacity,
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
          contentPadding: const EdgeInsets.only(top: 10, bottom: 20),
          onTap: () => Get.to(() => ViewLayout(
                receiver: ChatUserModel(
                    firstname: user.firstname,
                    lastname: user.lastname,
                    userId: user.userId,
                    phone: user.phone,
                    profileUrl: user.profileUrl),
              )),
          leading: Container(
            height: 104.h,
            width: 63.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    user.profileUrl ?? StringConstants.dummyProfilePicture),
              ),
            ),
          ),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              RichText(
                text: TextSpan(
                    text: '${user.firstname}',
                    children: [
                      TextSpan(
                          text: ' ${user.lastname}',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: AppColor.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400)),
                    ],
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
              ),
              SizedBox(width: 5.w),
              SvgPicture.asset(
                'assets/svgs/dot-icon.svg',
                height: 5,
                color: AppColor.blackColor,
              ),
              SizedBox(width: 5.w),
              LastDateContainer(
                stream: _chatMethods.fetchLastMessageBetween(
                  senderId:
                      Get.find<GlobalController>().user.value.id.toString(),
                  receiverId: contact.uid!,
                ),
              ),
            ],
          ),
          subtitle: LastMessageContainer(
            stream: _chatMethods.fetchLastMessageBetween(
              senderId: Get.find<GlobalController>().user.value.id.toString(),
              receiverId: contact.uid!,
            ),
          )),
    );
  }
}
