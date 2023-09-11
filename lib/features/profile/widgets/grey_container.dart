import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/profile/view/edit_profile.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/services/authentication/model/user_model.dart';

class GreyContainer extends StatelessWidget {
  const GreyContainer({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: EdgePainter(),
      child: Container(
          width: Get.width,
          height: 370.h,
          padding:
              const EdgeInsets.only(left: 20, right: 10, bottom: 20, top: 10),
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
                  userModel.firstName == '' && userModel.lastName == ''
                      ? _buildsubheading(context, text: "${userModel.userName}")
                      : _buildsubheading(context,
                          text: "${userModel.firstName} ${userModel.lastName}"),
                  SizedBox(
                    height: 13.h,
                  ),
                  Visibility(
                      visible:
                          userModel.firstName != '' && userModel.lastName != '',
                      child: _buildheading(context, text: "Date of birth")),
                  Visibility(
                    visible:
                        userModel.firstName != '' && userModel.lastName != '',
                    child: _buildsubheading(
                      context,
                      text: DateFormat("d 'of' MMM y")
                          .format(userModel.birthDate!),
                    ),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Visibility(
                      visible: userModel.phone != null,
                      child: _buildheading(context, text: "phone number")),
                  Visibility(
                    visible: userModel.phone != null,
                    child:
                        _buildsubheading(context, text: "${userModel.phone}"),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  Visibility(
                      visible: userModel.state != '' && userModel.country != '',
                      child: _buildheading(context, text: "location")),
                  Visibility(
                    visible: userModel.state != '' && userModel.country != '',
                    child: _buildsubheading(context,
                        text: "${userModel.state}, ${userModel.country}"),
                  ),
                  SizedBox(
                    height: 13.h,
                  ),
                  _buildheading(context, text: "email"),
                  _buildsubheading(context, text: "${userModel.email}"),
                ],
              ),
              Positioned(
                right: 2,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => EditProfileScreen());
                      },
                      child: Icon(
                        MdiIcons.pencil,
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
    style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w500, fontSize: 17, color: AppColor.blackColor),
  );
}

Widget _buildsubheading(BuildContext context, {required String text}) {
  return Text(
    text,
    maxLines: 2,
    style: Theme.of(context).textTheme.bodySmall!.copyWith(
        fontWeight: FontWeight.w600, fontSize: 17, color: AppColor.blackColor),
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
