import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../controller/profile_controller.dart';
import '../widgets/profile_section.dart';

// ignore: must_be_immutable
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
        body: FutureBuilder(
          future: ctr.getUserDetail(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: ShimmerManager.sectionShimmer(context),
                height: Get.height,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else if (snapshot.hasData) {
              debugPrint('-------------has data------------');

              return ProfileSection(
                user: snapshot.data!,
              );
            } else {
              debugPrint('-------------no data------------');
              return const SizedBox.shrink();
            }
          },
        ));
  }
}
