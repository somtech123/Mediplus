import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/appcolor.dart';

class CustomTab extends StatelessWidget {
  CustomTab(
      {super.key,
      required this.text,
      required this.index,
      required this.tabIndex});
  final String text;
  final int index;
  final int tabIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      width: 100.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: index == tabIndex
            ? AppColor.primaryColor
            : AppColor.greyWithOPacity,
        borderRadius: BorderRadius.all(Radius.circular(9.dm)),
      ),
      child: Text(text,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: index == tabIndex
                    ? AppColor.secondary
                    : AppColor.blackColor,
              )),
    );
  }
}
