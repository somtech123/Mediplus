import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';

import '../controller/splash_controller.dart';

@immutable
class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  var ctr = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svgs/medical-icon.svg',
              height: 150,
              color: AppColor.secondary,
            ),
            SizedBox(
              height: 30.h,
            ),
            const Text(
              "Mediplus",
              style: TextStyle(
                color: AppColor.secondary,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
