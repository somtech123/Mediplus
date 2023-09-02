import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/services/authentication/model/user_model.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../controller/profile_controller.dart';
import '../widgets/grey_container.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  var ctr = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        title: const Text(
          "Profile",
          style: TextStyle(color: AppColor.blackColor, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
          child: Column(children: [
            SizedBox(
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    maxRadius: 80,
                    backgroundImage: AssetImage(
                      'assets/images/doc1.jpg',
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 100,
                          // bottom: ,
                          left: 100,
                          child: Icon(
                            Icons.camera,
                            color: AppColor.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text("tega swift"),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text("@data"),
                  SizedBox(
                    height: 25.h,
                  ),
                  _buildCustomContainer(context,
                      text: "My Appointment", ontap: () {}),
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
                  FutureBuilder<UserModel>(
                    future: ctr.getUserDetail(),
                    //ctr.userServices.getUserDetails(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ShimmerManager.sectionShimmer(context);
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        debugPrint('-------------has data------------');
                        // UserModel user = snapshot.data!;
                        return GreyContainer(
                          userModel: snapshot.data!,
                        );
                      } else {
                        debugPrint('-------------no data------------');
                        return SizedBox();
                      }
                    },
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
      ),
    );
  }
}

Widget _buildCustomContainer(BuildContext context,
    {required String text, required VoidCallback ontap}) {
  return Container(
    height: 50.h,
    width: Get.width,
    decoration: BoxDecoration(
        color: AppColor.greyColor.withOpacity(0.3),
        borderRadius: const BorderRadius.all(Radius.circular(12))),
    child: ListTile(
      title: Text(text),
      onTap: () => ontap,
      trailing: const Icon(
        Icons.arrow_back_ios_new,
        size: 20,
        color: AppColor.blackColor,
      ),
    ),
  );
}
