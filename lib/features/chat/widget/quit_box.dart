import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediplus/core/constant/appcolor.dart';

class QuietBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // LottieBuilder.asset(
              //   'assets/json/no_data.json',
              //   frameRate: FrameRate(60),
              //   height: 150.h,
              // ),
              const Text(
                "No messages yet",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColor.greyColor),
              ),

              SizedBox(height: 25.h),
            ],
          ),
        ),
      ),
    );
  }
}
