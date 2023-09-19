import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediplus/core/constant/appcolor.dart';

class CustomTimeContainer extends StatelessWidget {
  CustomTimeContainer(
      {super.key,
      required this.ontap,
      required this.time,
      this.isActive = false});
  final Function() ontap;
  final String time;
  bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 30.h,
        width: 80.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isActive ? AppColor.primaryColor : AppColor.greyWithOPacity,
          borderRadius: BorderRadius.circular(5.r),
        ),
        child: Text(
          time,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 14,
              color: isActive ? AppColor.secondary : AppColor.blackColor),
        ),
      ),
    );
  }
}
