import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediplus/features/profile/view/track_appointment.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/constant/string_constant.dart';
import '../../../core/services/user/model/appointment_model.dart';
import '../../../core/utlis/utlis.dart';

class AppointmentTile extends StatelessWidget {
  AppointmentTile({super.key, required this.appointment, required this.onTap});
  final AppointmentModel appointment;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      width: Get.width,
      padding: EdgeInsets.only(left: 10.h, top: 5.h, right: 10.h),
      decoration: BoxDecoration(
          color: AppColor.greyWithOPacity,
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: Container(
          height: 40.h,
          width: 63.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(appointment.doctorPhoto ??
                  StringConstants.dummyProfilePicture),
            ),
          ),
        ),
        title: RichText(
          text: TextSpan(
              text:
                  'Dr ${appointment.doctorFirstName} ${appointment.doctorLastName}',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 15,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w500),
              children: [
                TextSpan(
                  text: "\n${appointment.specialist}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 12,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w300),
                ),
              ]),
        ),
        subtitle: Row(
          children: [
            Icon(
              Icons.calendar_month,
              size: 20.h,
              color: AppColor.primaryColor,
            ),
            Text(
              DateFormat('dd MMMM, yyyy').format(appointment.appointnmentDate!),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  fontSize: 10,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w300),
            )
          ],
        ),
        trailing: Column(
          children: [
            Icon(
              Icons.phone,
              size: 20.h,
              color: AppColor.blackColor,
            ),
            SizedBox(height: 5.h),
            status(context, status: '${appointment.appointmentStatus}')
          ],
        ),
      ),
    );
  }
}

Widget status(BuildContext context, {required String status}) {
  return Container(
    height: 20.h,
    width: 70.w,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: AppColor.greyWithOPacity,
        borderRadius: BorderRadius.circular(12)),
    child: Text(
      status,
      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 12,
          color: Utils.getColor(status),
          fontWeight: FontWeight.w500),
    ),
  );
}
