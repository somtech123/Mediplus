import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/appcolor.dart';
import '../../../../core/shared_widgets/primary_button.dart';
import '../../controller/doctor_detail_controller.dart';
import '../../screen/appointment.dart';

// ignore: must_be_immutable
class DocInfo extends StatelessWidget {
  DocInfo({super.key});

  var ctr = Get.find<DoctorDetailController>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _headingText(context, text: 'Hospital'),
          // SizedBox(height: 10.h),
          _headingText(context, text: '${ctr.doc.hospital}'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Designation'),
          _subheadingText(context, text: '${ctr.doc.designation}'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Department'),
          _subheadingText(context, text: '${ctr.doc.department}'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Employment period'),
          _subheadingText(context,
              text: DateFormat('d of MMM y').format(ctr.doc.experience!)),
          SizedBox(height: 10.h),
          Text(
            "About Doctor",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 16,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w800),
          ),
          ExpandableText(
            '${ctr.doc.bio}',
            expandText: 'See More',
            collapseText: 'See Less',
            maxLines: 3,
          ),
          SizedBox(height: 20.h),
          BorderButton(
            ontap: () {
              Get.to(() => AppoinmentScreen(), arguments: ctr.doc);
            },
            text: 'Book Appointment',
          )
        ],
      ),
    );
  }

  Widget _headingText(BuildContext context, {required String text}) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 17,
          color: AppColor.blackColor),
    );
  }

  Widget _subheadingText(BuildContext context, {required String text}) {
    return Text(
      text,
      maxLines: 2,
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 15,
          color: AppColor.blackColor),
    );
  }
}
