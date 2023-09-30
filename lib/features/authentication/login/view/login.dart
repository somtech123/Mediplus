import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/appcolor.dart';
import '../../../../core/shared_widgets/custom_divider.dart';
import '../../../../core/shared_widgets/custom_textfield.dart';
import '../../../../core/shared_widgets/primary_button.dart';
import '../../reset/view/reset_password.dart';
import '../../sign_up/view/signup.dart';
import '../../widget/social_media_widget.dart';
import '../controller/login_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var ctr = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  RichText(
                    text: TextSpan(
                      text: "Let's Sign in",
                      style: Theme.of(context).textTheme.caption!.copyWith(
                          color: AppColor.blackColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700),
                      children: [
                        TextSpan(
                          text: '\nWelcome back, you\'ve',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: AppColor.greyColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        TextSpan(
                          text: '\nbeen missed!',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              color: AppColor.greyColor,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50.h),
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
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        child: Text(
                          "Forgotten Password?",
                          style: Theme.of(context).textTheme.button!.copyWith(
                              color: AppColor.primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700),
                        ),
                        onTap: () {
                          Get.to(() => ResetPassWord());
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  PrimaryButton(
                      label: 'Sign in',
                      onPressed: () {
                        ctr.validateInput();
                      }),
                  SizedBox(
                    height: 10.h,
                  ),
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
                              text: 'Create account',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: AppColor.errorColor,
                                      fontSize: 15.sp),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => SignUPSceen());
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
                  SocialMediaButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
