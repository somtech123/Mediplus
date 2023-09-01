import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/appcolor.dart';
import '../../../../core/shared_widgets/custom_textfield.dart';
import '../../../../core/shared_widgets/primary_button.dart';
import '../controller/reset_controller.dart';

class ResetPassWord extends StatelessWidget {
  ResetPassWord({super.key});
  var ctr = Get.put(ResetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                RichText(
                  text: TextSpan(
                    text: "Forgot Password",
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: '\nWe need your registration email account to',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: AppColor.greyColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      TextSpan(
                        text: '\nsend you password reset code',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: AppColor.greyColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                Obx(
                  () => CustomBorderTextField(
                    hintText: 'Your Email',
                    controller: ctr.emailController,
                    onChanged: (p) => ctr.clearError(ctr.emailErrorText),
                    errorMessage: ctr.emailErrorText.value,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      child: Text(
                        "Resend code",
                        style: Theme.of(context).textTheme.button!.copyWith(
                            color: AppColor.primaryColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 150.h,
                ),
                PrimaryButton(
                    label: 'Send',
                    onPressed: () {
                      ctr.validateInput();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
