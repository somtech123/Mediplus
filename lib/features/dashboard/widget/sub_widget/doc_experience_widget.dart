import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/appcolor.dart';

class DocExperience extends StatelessWidget {
  const DocExperience({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _headingText(context, text: 'st hokin hosipal'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Designation'),
          _subheadingText(context, text: 'residential medical doctor'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Department'),
          _subheadingText(context, text: 'Obs'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Employment period'),
          _subheadingText(context, text: '23 of jan 2001'),
          SizedBox(height: 10.h),
          _headingText(context, text: 'Job Description'),
          const ExpandableText(
            'This is a long text that can be expanded to show more. Click "See More" to expand and collapse the text as needed.',
            expandText: 'See More',
            collapseText: 'See Less',
            maxLines: 3,
          ),
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
