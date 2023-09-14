import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/constant/appcolor.dart';
import '../../../../core/shared_widgets/primary_button.dart';
import '../../controller/doctor_detail_controller.dart';
import '../../screen/appointment.dart';

class DocInfo extends StatelessWidget {
  DocInfo({super.key});

  var ctr = Get.find<DoctorDetailController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "About Doctor",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 16,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w800),
          ),
          const ExpandableText(
            'This is a long text that can be expanded to show more. Click "See More" to expand and collapse the text as needed.',
            expandText: 'See More',
            collapseText: 'See Less',
            maxLines: 3,
          ),
          SizedBox(height: 20.h),
          BorderButton(
            ontap: () {
              Get.to(() => AppoinmentScreen(), arguments: ctr.bodyBytes);
            },
            text: 'Book Appointment',
          )
        ],
      ),
    );
  }
}
