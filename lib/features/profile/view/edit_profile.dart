import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';

import '../../../core/shared_widgets/app_textfield.dart';
import '../../../core/shared_widgets/primary_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.secondary,
        iconTheme: IconThemeData(color: AppColor.blackColor),
        title: Text(
          "Change Profile",
          style: TextStyle(color: AppColor.blackColor, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.h,
            ),
            AppTextField(
              labelText: 'Name',
              min: true,
            ),
            AppTextField(
              labelText: 'Name',
              min: true,
            ),
            AppTextField(
              labelText: 'Name',
              min: true,
            ),
            Text("Date of birth"),
            SizedBox(
              height: 20.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 120.w,
                  child: AppTextField(labelText: 'Name', min: false),
                ),
                SizedBox(
                  width: 120.w,
                  child: AppTextField(labelText: 'Name', min: false),
                ),
                SizedBox(
                  width: 120.w,
                  child: AppTextField(labelText: 'Name', min: false),
                ),
              ],
            ),
            AppTextField(
              labelText: 'Name',
              min: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: PrimaryButton(
                label: 'jj',
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
