import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared_widgets/loading_widgets.dart';

class SocialMediaButton extends StatelessWidget {
  const SocialMediaButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          child: Row(
            children: [
              SvgPicture.asset('assets/svgs/icons8-google.svg'),
              Text(
                'Google',
                style: Theme.of(context).textTheme.caption!.copyWith(
                      fontSize: 15.sp,
                      color: AppColor.blackColor,
                    ),
              )
            ],
          ),
        ),
        Row(
          children: [
            SvgPicture.asset('assets/svgs/icons8-apple-logo.svg'),
            Text(
              'Apple',
              style: Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 15.sp,
                    color: AppColor.blackColor,
                  ),
            )
          ],
        ),
      ],
    );
  }
}
