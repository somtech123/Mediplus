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
          //   leading: SvgPicture.asset('assets/svgs/Alert icons.svg'),
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

buildLogoutAlertWidget(BuildContext context,
    {required VoidCallback action1, VoidCallback? action2}) {
  return buildCustomAlertWidgetWrapper(context,
      color: AppColor.alert,
      bgColor: AppColor.alert,
      widget: Column(
        children: [
          ListTile(
            leading: SvgPicture.asset('assets/svgs/alert_icon.svg'),
            title: Text(
              "Confirm Logout",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColor.blackColor),
            ),
            trailing: InkWell(
              child: SvgPicture.asset('assets/svgs/Dissmiss.svg'),
              onTap: () => Get.back(),
            ),
            subtitle: Text(
              "Are you sure you want to log out? You will be signed out of your account, confirm your decision to proceed.",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: AppColor.blackColor),
            ),
          ),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 120.w,
                height: 50.h,
                child: SmallButton(
                  onPressed: action1,
                  label: 'Yes, Logout',
                  labelColor: AppColor.secondary,
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(
                width: 120.w,
                height: 50.h,
                child: SmallButton(
                  onPressed: action2 ?? () => Get.back(),
                  hideBorder: true,
                  label: 'No, Cancel',
                  labelColor: AppColor.blackColor,
                  backgroundColor: Colors.transparent,
                ),
              ),
            ],
          )
        ],
      ));
}
