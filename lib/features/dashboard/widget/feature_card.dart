import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';

import '../../appointment/appointment.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildFeatureCard(context,
            icon: MaterialCommunityIcons.doctor, text: "Doctor", ontap: () {}),
        _buildFeatureCard(context,
            icon: MaterialCommunityIcons.calendar,
            text: "Appointment", ontap: () {
          Get.to(() => AppoinmentScreen());
        }),
        _buildFeatureCard(context,
            icon: MaterialCommunityIcons.prescription,
            text: "Prescription",
            ontap: () {}),
        _buildFeatureCard(context,
            icon: MaterialCommunityIcons.medical_bag,
            text: "Medicine",
            ontap: () {}),
        _buildFeatureCard(context,
            icon: MaterialCommunityIcons.calendar,
            text: "Treatment",
            ontap: () {}),
      ],
    );
  }
}

Widget _buildFeatureCard(BuildContext context,
    {required IconData icon,
    required String text,
    required VoidCallback ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: 55.h,
      width: 60.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColor.greyColor,
          )),
      child: Column(
        children: [
          SizedBox(
            height: 5.h,
          ),
          Icon(
            icon,
            color: AppColor.primaryColor,
          ),
          Text(
            text,
            style: const TextStyle(
                color: AppColor.primaryColor,
                fontSize: 10,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
