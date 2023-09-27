import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/constant/string_constant.dart';
import '../../../core/services/user/model/doctor_model.dart';
import '../../../core/shared_widgets/primary_button.dart';

customBottomSheet(BuildContext context,
    {required VoidCallback yesTap,
    required VoidCallback noTap,
    required DoctorModel user}) {
  return Get.bottomSheet(
    Material(
      borderRadius: const BorderRadius.only(
          topRight: Radius.circular(25), topLeft: Radius.circular(25)),
      child: Container(
        height: 280.h,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              layout(context, user: user),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: Text(
                  'Remove from favourite?',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 150.w,
                    child: BorderButton(
                      ontap: noTap,
                      text: 'Cancel',
                    ),
                  ),
                  SizedBox(
                      width: 150.w,
                      child: PrimaryButton(
                          label: 'Yes, Remove', onPressed: yesTap)),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget layout(BuildContext context, {required DoctorModel user}) {
  return Container(
    height: 80.h,
    width: Get.width,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      border: Border.all(color: AppColor.greyColor),
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    child: Row(
      children: [
        Container(
          height: 60.h,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
            image: DecorationImage(
                image: NetworkImage(
                    user.photo ?? StringConstants.dummyProfilePicture)),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Doctor ${user.firstname} ${user.lastname}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor,
                    ),
              ),
              SizedBox(
                height: 15.h,
                child: Row(
                  children: [
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => SvgPicture.asset(
                          "assets/svgs/rating-full-icon.svg",
                          color: AppColor.ratingColor,
                          height: 15,
                        ),
                        itemCount: int.parse('${user.rating}'),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${user.specialist} -${user.hospital}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColor.blackColor,
                    ),
                maxLines: 1,
              )
            ],
          ),
        ),
        const Icon(
          Icons.favorite,
          color: AppColor.primaryColor,
        ),
      ],
    ),
  );
}
