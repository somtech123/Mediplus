import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared_widgets/primary_button.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 30.h),
            Center(
              child: SvgPicture.asset(
                'assets/svgs/medical-icon.svg',
                height: 70.h,
                color: AppColor.primaryColor,
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Center(
              child: Text(
                "Mediplus",
                style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 28,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 70.h),
            Container(
              height: Get.height * 0.3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/confetti.png'))),
            ),
            SizedBox(height: 30.h),
            Text(
              'Congratulation!',
              style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 28,
                  color: AppColor.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              'Welcome to Mediplus',
              style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 18,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20.h,
            ),
            PrimaryButton(label: 'Go to Homepage', onPressed: () {}),
          ]),
        ),
      ),
    );
  }
}
