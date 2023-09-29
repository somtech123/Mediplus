import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

appBottomSheet(BuildContext context) {
  return Get.bottomSheet(
    Material(
      child: Container(
        height: 200.h,
      ),
    ),
  );
}
