import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/profile/view/edit_profile.dart';
import 'dart:math' as math;

import '../../../core/constant/appcolor.dart';

class GreyContainer extends StatelessWidget {
  const GreyContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: EdgePainter(),
      child: Container(
          width: Get.width,
          height: 500.h,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColor.greyColor.withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(12))),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Personal Information",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  _buildheading(context, text: "name"),
                  _buildsubheading(context, text: "Tega Swift"),
                  SizedBox(
                    height: 13.h,
                  ),
                  _buildheading(context, text: "Date of birth"),
                  _buildsubheading(context, text: "25 of feb 2021"),
                  SizedBox(
                    height: 13.h,
                  ),
                  _buildheading(context, text: "phone number"),
                  _buildsubheading(context, text: "+123456789"),
                  SizedBox(
                    height: 13.h,
                  ),
                  _buildheading(context, text: "address"),
                  _buildsubheading(context,
                      text: "12 lafage kitchen umuchima owerri"),
                  SizedBox(
                    height: 13.h,
                  ),
                  _buildheading(context, text: "email"),
                  _buildsubheading(context, text: "somtech@somteh.com"),
                ],
              ),
              Positioned(
                left: Get.width * 0.7,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => EditProfileScreen());
                      },
                      child: const Icon(
                        MaterialCommunityIcons.pencil,
                        color: AppColor.secondary,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    const SizedBox(
                      height: 2,
                      width: 30,
                      child: Divider(
                        thickness: 2,
                        color: AppColor.secondary,
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }
}

Widget _buildheading(BuildContext context, {required String text}) {
  return Text(
    text,
    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
  );
}

Widget _buildsubheading(BuildContext context, {required String text}) {
  return Text(
    text,
    maxLines: 2,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
  );
}

class EdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.primaryColor
      ..strokeWidth = 2.0;

    final curveHeight = size.height * 0.2;
    final curveWidth = size.width * 0.95;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(230, 0)
      ..quadraticBezierTo(
        curveWidth,
        curveHeight,
        size.width,
        curveHeight,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
