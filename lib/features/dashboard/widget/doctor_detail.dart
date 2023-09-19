import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/features/dashboard/widget/doctor_detail_tab.dart';

import '../../../core/constant/string_constant.dart';
import '../../../core/shared_widgets/primary_button.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../controller/doctor_detail_controller.dart';

// ignore: must_be_immutable
class DoctorDetailPage extends StatelessWidget {
  DoctorDetailPage({super.key});
  var ctr = Get.put(DoctorDetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColor.secondary,
          iconTheme: const IconThemeData(color: AppColor.blackColor),
          title: Text("Doctor Profile",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
        ),
        body:
            // Obx(() => ctr.isLoading.value
            //     ? Container(
            //         child: ShimmerManager.sectionShimmer(context),
            //         height: 100.h,
            //         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            //       )
            //     :
            SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 150.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    //color: AppColor.greyWithOPacity,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.dm),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60.w * 2,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(ctr.doc.photo ??
                                StringConstants.dummyProfilePicture),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Doctor ${ctr.doc.firstname} ${ctr.doc.lastname}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: AppColor.blackColor),
                          ),
                          Text(
                            '${ctr.doc.specialist}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 14),
                          ),
                          _ratingBar(context,
                              rating: double.parse('${ctr.doc.rating}')),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _greyContainer(context,
                        heading: 'Patient', subHeading: '45.7k'),
                    _greyContainer(context,
                        heading: 'Experiences', subHeading: '7 years'),
                    _greyContainer(context,
                        heading: 'Reviews', subHeading: '6.0k')
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GreyButton(
                        ontap: () {}, text: 'Audio call', icon: Icons.call),
                    GreyButton(
                        ontap: () {},
                        text: 'video call',
                        icon: Icons.video_call),
                    GreyButton(
                        ontap: () {}, text: 'message', icon: Icons.message),
                  ],
                ),
                const DoctorDetailTabWidget()
              ],
            ),
          ),
        )
        //),
        );
  }

  Widget _buildDoctorInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: 'Dr. abbas samuel',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                    color: AppColor.blackColor,
                    fontWeight: FontWeight.w500,
                  ),
              children: [
                TextSpan(
                  text: "\nMBBS",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 18,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ]),
        ),
        SizedBox(height: 5.h),
        Text(
          "surgon",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 17,
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w500,
              ),
        )
      ],
    );
  }

  Widget _ratingBar(BuildContext context, {required double rating}) {
    bool isRated = false;
    return RatingBar.builder(
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColor.rating,
      ),
      initialRating: double.parse('5'),
      minRating: 0,
      maxRating: 5,
      itemSize: 15.h,
      ignoreGestures: true,
      onRatingUpdate: (value) {},
    );
  }

  Widget _greyContainer(BuildContext context,
      {required String heading, required String subHeading}) {
    return Container(
      height: 45.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColor.greyWithOPacity,
        borderRadius: BorderRadius.all(
          Radius.circular(5.dm),
        ),
      ),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: heading,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 16,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500,
              ),
          children: [
            TextSpan(
              text: "\n$subHeading",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
