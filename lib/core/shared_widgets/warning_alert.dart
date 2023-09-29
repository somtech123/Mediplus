import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mediplus/core/shared_widgets/alert_wrapper.dart';
import 'package:mediplus/core/shared_widgets/primary_button.dart';

import '../constant/appcolor.dart';

showWarningAlertWidget(BuildContext context,
    {String? message,
    VoidCallback? action,
    required VoidCallback action2,
    String? label,
    String? label2,
    bool isDoubleButton = false,
    String? imageUri = 'assets/images/anxious.png'}) {
  return buildCustomAlertWidgetWrapper(
    context,
    widget: Column(
      children: [
        Image.asset(
          imageUri!,
        ),
        SizedBox(height: 17.51.h),
        Semantics(
          child: Text(
            message ?? 'An error occurred, please try again later.',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
                color: AppColor.blackColor),
            semanticsLabel:
                message ?? 'An error occurred, please try again later.',
          ),
        ),
        const Spacer(),
        if (!isDoubleButton)
          PrimaryButton(
            label: label ?? 'dismiss',
            labelColor: AppColor.primaryColor,
            onPressed: action,
            // backgroundColor: AppColors.black,
            // accentColor: AppColors.buttonOverlay,
          ),
        // SizedBox(height: h(23.0)),
        if (isDoubleButton)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 110,
                child: BorderButton(
                  ontap: action2,
                  text: label2 ?? 'Cancel',
                ),

                //  PrimaryButton(
                //   label: label2 ?? 'dismiss',
                //   labelColor: AppColor.alert,
                //   onPressed: action2,
                // ),
              ),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 110,
                child: PrimaryButton(label: label ?? 'Ok', onPressed: action),
              ),
            ],
          ),

        SizedBox(
          height: 30.h,
        )
      ],
    ),
  );
}
