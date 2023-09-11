import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/appcolor.dart';
import '../../../../core/shared_widgets/primary_button.dart';

class DocInfo extends StatelessWidget {
  const DocInfo({super.key});

  //bool isExpanded = false;

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
            ontap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_call,
                  color: AppColor.primaryColor,
                  size: 40.h,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Text(
                  'see doctor',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
