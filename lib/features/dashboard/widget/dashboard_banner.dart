import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediplus/core/constant/appcolor.dart';

import '../../../core/constant/string_constant.dart';
import '../../../core/services/user/model/doctor_model.dart';

// ignore: must_be_immutable
class DashboardBanner extends StatelessWidget {
  DashboardBanner({super.key, required this.user, required this.ontap});
  final DoctorModel user;
  VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150.h,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.primaryColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "Looking for your ${user.specialist}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.secondary,
                                ),
                            children: const [
                              TextSpan(text: "\nSpecialist Doctor?"),
                            ]),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        "Doctor ${user.firstname} ${user.lastname}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColor.secondary,
                            ),
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => SvgPicture.asset(
                            "assets/svgs/rating-full-icon.svg",
                            color: AppColor.ratingColor,
                            height: 15,
                          ),
                          itemCount: int.parse(user.rating!),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.w,
                ),
                Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.contain,
                          image: NetworkImage(user.photo ??
                              StringConstants.dummyProfilePicture))),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
