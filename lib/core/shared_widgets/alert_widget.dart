import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/shared_widgets/primary_button.dart';

import '../constant/appcolor.dart';
import '../utlis/navigation_function.dart';
import 'alert_wrapper.dart';

showErrorAlertWidget(BuildContext context,
    {String? message,
    Function? action,
    String? label,
    Color? btnColor,
    Color? labelColor,
    bool showButton = true,
    bool longText = false,
    bool barrierDismissible = false,
    String? title}) {
  return buildCustomAlertWidgetWrapper(
    context,
    bgColor: AppColor.alert,
    barrierDismissible: barrierDismissible,
    color: AppColor.alert,
    //const Color.fromARGB(255, 178, 204, 221),
    size: Size(
        400.0.w,
        showButton
            ? 300.0.h
            : longText == true
                ? 300.h
                : 230.h),
    widget: Column(
      children: [
        ListTile(
          leading: SvgPicture.asset('assets/svgs/Alert icons.svg'),
          trailing: InkWell(
              onTap: () => Get.back(),
              child: SvgPicture.asset('assets/svgs/dimiss_button.svg')),
          title: Text(
            title ?? "",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: AppColor.blackColor),
          ),
        ),
        SizedBox(height: 17.51.h),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            message ?? 'An error occured, please try again later.',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: AppColor.blackColor),
          ),
        ),
        const Spacer(),
        Visibility(
          visible: showButton,
          child: PrimaryButton(
            label: label ?? 'Dismiss',
            onPressed: action ?? () => pop(),
          ),
        ),
        SizedBox(height: 17.51.h),
      ],
    ),
  );
}
