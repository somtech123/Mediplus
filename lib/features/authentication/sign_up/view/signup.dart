import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/core/shared_widgets/primary_button.dart';

import '../../../../core/shared_widgets/custom_divider.dart';
import '../../../../core/shared_widgets/custom_textfield.dart';
import '../../login/view/login.dart';
import '../controller/signup_controller.dart';
import '../../widget/social_media_widget.dart';

// ignore: must_be_immutable
class SignUPSceen extends StatelessWidget {
  SignUPSceen({super.key});

  var ctr = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),
                RichText(
                  text: TextSpan(
                    text: 'Get Started',
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: AppColor.blackColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                        text: '\nCreate an account',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              color: AppColor.blackColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w300,
                            ),
                      ),
                      TextSpan(
                        text: '\nto continue',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: AppColor.blackColor,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ),
                CustomBorderTextField(
                  hintText: 'First Name',
                  controller: ctr.fnameController,
                  errorMessage: ctr.fnameErrorText.value,
                  onChanged: (p) => ctr.clearError(ctr.fnameErrorText),
                ),
                SizedBox(height: 20.h),
                CustomBorderTextField(
                  hintText: 'Last name',
                  controller: ctr.lnameController,
                  errorMessage: ctr.lnameErrorText.value,
                  onChanged: (p) => ctr.clearError(ctr.lnameErrorText),
                ),
                SizedBox(height: 20.h),
                CustomBorderTextField(
                  hintText: 'Username',
                  controller: ctr.usernameController,
                  onChanged: (p0) => ctr.clearError(ctr.usernameError),
                  errorMessage: ctr.usernameError.value,
                ),
                SizedBox(height: 20.h),
                CustomBorderTextField(
                  hintText: 'Your Email',
                  controller: ctr.emailController,
                  onChanged: (p) => ctr.clearError(ctr.emailErrorText),
                  errorMessage: ctr.emailErrorText.value,
                ),
                SizedBox(height: 20.h),
                CustomBorderTextField(
                  hintText: 'Password',
                  maxLines: 1,
                  obscureText: ctr.isVisible.value,
                  controller: ctr.passwordController,
                  errorMessage: ctr.passwordErrorText.value,
                  onChanged: (p0) => ctr.clearError(ctr.passwordErrorText),
                  suffix: IconButton(
                    icon: Icon(
                      !ctr.isVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: AppColor.primaryColor,
                    ),
                    onPressed: () {
                      ctr.isVisible.value = !ctr.isVisible.value;
                    },
                  ),
                ),
                SizedBox(height: 40.h),
                PrimaryButton(
                    label: 'Create Account',
                    onPressed: () {
                      ctr.validateInput();
                    }),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            color: AppColor.blackColor, fontSize: 15.sp),
                        children: [
                          TextSpan(
                            text: 'Sign in',
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                                    color: AppColor.errorColor,
                                    fontSize: 15.sp),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => LoginScreen());
                              },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                const CustomDivider(),
              //0  SocialMediaButton()
              ],
            ),
          ),
        ),
      )),
    );
  }
}
