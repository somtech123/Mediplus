import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/constant/string_constant.dart';
import '../../../core/services/user/model/appointment_model.dart';
import '../../../core/utlis/utlis.dart';
import '../widgets/appointment_tile.dart';

class TrackAppointment extends StatelessWidget {
  const TrackAppointment({super.key, required this.appointment});
  final AppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.secondary,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: Text(
          "View Appointment",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: AppColor.blackColor, fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
          child: Column(
            children: [
              Container(
                height: 70.h,
                width: Get.width,
                padding: EdgeInsets.only(left: 10.h, top: 5.h, right: 10.h),
                decoration: BoxDecoration(
                    color: AppColor.greyWithOPacity,
                    borderRadius: BorderRadius.circular(12)),
                child: ListTile(
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
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
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
                        DateFormat('dd MMMM, yyyy')
                            .format(appointment.appointnmentDate!),
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
                      status(context,
                          status: '${appointment.appointmentStatus}')
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              _buildvisitContainer(context),
              SizedBox(height: 20.h),
              _buildPatientInfoLayout(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientInfoLayout(BuildContext context) {
    return Container(
      height: 180.h,
      width: Get.width,
      padding: EdgeInsets.only(left: 25.h, right: 10.h),
      decoration: BoxDecoration(
        color: AppColor.greyWithOPacity,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "Patient info",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 15,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20.h),
          rowLayout(context,
              header: 'SN', subHeader: '${appointment.appointmentSN}'),
          SizedBox(height: 10.h),
          rowLayout(context,
              header: 'Full name', subHeader: '${appointment.patientName}'),
          SizedBox(height: 10.h),
          rowLayout(context,
              header: 'Age',
              subHeader:
                  Utils.calculateAge(appointment.patientDob!).toString()),
          SizedBox(height: 10.h),
          rowLayout(context,
              header: 'phone', subHeader: '${appointment.patientPhone}'),
          SizedBox(height: 10.h),
          rowLayout(context,
              header: 'Weight', subHeader: '${appointment.patientWeight} KG')
        ],
      ),
    );
  }

  Widget rowLayout(BuildContext context,
      {required String header, required String subHeader}) {
    return Row(
      children: [
        Text(
          header,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 12,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          ':',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 12,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          subHeader,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: 12,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w500),
        )
      ],
    );
  }

  Widget _buildvisitContainer(BuildContext context) {
    return Container(
      height: 100.h,
      width: Get.width,
      padding: EdgeInsets.only(left: 25.h, right: 10.h),
      decoration: BoxDecoration(
        color: AppColor.greyWithOPacity,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20.h),
          Text(
            "Vist time",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 15,
                color: AppColor.blackColor,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.h),
          Text(
            DateFormat('EEEE, MMMM dd, yyyy')
                .format(appointment.appointnmentDate!),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 12,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 5.h),
          Text(
            DateFormat('h:mm a').format(appointment.appointmentTime!),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 12,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
