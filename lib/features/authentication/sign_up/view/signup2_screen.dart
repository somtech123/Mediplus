import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mediplus/features/authentication/sign_up/view/success.dart';

import '../../../../core/constant/appcolor.dart';
import '../../../../core/shared_widgets/custom_textfield.dart';
import '../../../../core/shared_widgets/primary_button.dart';
import '../../widget/phone_text_field.dart';
import '../controller/signup2_controller.dart';

class SignUpTwoScreen extends StatelessWidget {
  SignUpTwoScreen({super.key});

  var ctr = Get.put(SignUp2Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              Center(
                child: SvgPicture.asset(
                  'assets/svgs/medical-icon.svg',
                  height: 70.h,
                  color: AppColor.primaryColor,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Center(
                child: Text(
                  "Mediplus",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 28,
                      color: AppColor.primaryColor,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 20.h),
              PhoneTextField(
                controller: ctr.phoneController,
                errorMessage: ctr.phoneErrorText.value,
              ),
              SizedBox(
                width: 100.w,
                child: CustomBorderTextField(
                  hintText: 'Age',
                ),
              ),
              SizedBox(height: 10.h),
              RadioGroup<String>.builder(
                direction: Axis.vertical,
                textStyle:
                    Theme.of(context).textTheme.button!.copyWith(fontSize: 12),
                groupValue: ctr.gender.value,
                activeColor: AppColor.primaryColor,
                onChanged: (value) {
                  ctr.setGender(value!);
                },
                items: const ['Male', 'Female', 'others'],
                itemBuilder: (item) => RadioButtonBuilder(
                  item,
                ),
              ),
              SizedBox(height: 50.h),
              PrimaryButton(
                  label: 'Continue',
                  onPressed: () {
                    Get.to(() => SuccessScreen());
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
