import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/profile/widgets/grey_container.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/constant/string_constant.dart';
import '../../../core/services/authentication/model/user_model.dart';
import '../controller/profile_controller.dart';
import '../view/appointment_history.dart';

// ignore: must_be_immutable
class ProfileSection extends StatelessWidget {
  ProfileSection({super.key, required this.user});
  final UserModel user;
  var ctr = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
        child: Column(children: [
          SizedBox(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      maxRadius: 50,
                      backgroundImage: user.profileImage!.isEmpty
                          ? NetworkImage(StringConstants.dummyProfilePicture)
                          : NetworkImage(user.profileImage!),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: SvgPicture.asset('assets/svgs/ic_camera.svg'),
                    ),
                  ],
                ),
                Text(
                  "${user.firstName} ${user.lastName}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: AppColor.blackColor),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  "@${user.userName}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w300,
                      fontSize: 17,
                      color: AppColor.blackColor),
                ),
                SizedBox(
                  height: 25.h,
                ),
                _buildCustomContainer(context, text: "My Appointment",
                    ontap: () {
                  Get.to(() => AppointmentHistory());
                }),
                SizedBox(
                  height: 30.h,
                ),
                _buildCustomContainer(
                  context,
                  text: "History",
                  ontap: () {},
                ),
                SizedBox(
                  height: 30.h,
                ),
                GreyContainer(
                  userModel: user,
                ),
                SizedBox(
                  height: 30.h,
                ),
                GestureDetector(
                  onTap: () => ctr.authservices.signOut(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 17,
                            color: Colors.red),
                      ),
                      SizedBox(width: 10.w),
                      SvgPicture.asset(
                        'assets/svgs/logout.svg',
                        height: 25,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildCustomContainer(BuildContext context,
      {required String text, required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50.h,
        width: Get.width,
        decoration: BoxDecoration(
            color: AppColor.greyColor.withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(12))),
        child: ListTile(
          title: Text(text),
          trailing: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColor.blackColor,
          ),
        ),
      ),
    );
  }
}
