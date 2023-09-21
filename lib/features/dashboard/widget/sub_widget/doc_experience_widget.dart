import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/constant/appcolor.dart';
import '../../../../core/services/user/model/doctor_model.dart';

// ignore: must_be_immutable
class DocExperience extends StatelessWidget {
  DocExperience({super.key, required this.doc});
  DoctorModel doc;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _headingText(context, text: '${doc.hospital}'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Designation'),
          _subheadingText(context, text: '${doc.designation}'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Department'),
          _subheadingText(context, text: '${doc.department}'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Employment period'),
          _subheadingText(context,
              text: DateFormat('d of MMM y').format(doc.experience!)),
          // SizedBox(height: 10.h),
          // _headingText(context, text: 'Job Description'),
          // const ExpandableText(
          //   'This is a long text that can be expanded to show more. Click "See More" to expand and collapse the text as needed.',
          //   expandText: 'See More',
          //   collapseText: 'See Less',
          //   maxLines: 3,
          // ),
          SizedBox(height: 20.h),
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
