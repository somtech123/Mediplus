import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/core/services/user/model/doctor_model.dart';
import 'package:mediplus/features/dashboard/controller/dashboard_controller.dart';

import '../../../core/constant/string_constant.dart';
import '../../../core/services/user/usecase.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../screen/doctor_detail.dart';

// ignore: must_be_immutable
class DashboardCard extends StatelessWidget {
  DashboardCard({super.key});

  var ctr = Get.find<DashboardController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Top Doctor",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              fontSize: 15,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 20.h,
        ),
        FutureBuilder(
          future: UserServices().getAllDoctors(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(
                child: ShimmerManager.sectionShimmer(context),
                height: 200.h,
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            } else if (snapshot.hasData) {
              final user = snapshot.data!
                  .where((element) => element.rating == '5')
                  .toList();
              return SizedBox(
                height: 180.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: user.length,
                  // snapshot.data!.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.h),
                    child: CustomPgeView(
                        ontap: () {
                          Get.to(() => DoctorDetailPage(),
                              arguments: user[index]);
                        },
                        user: user[index]
                        // snapshot.data![index],
                        ),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}

class CustomPgeView extends StatelessWidget {
  const CustomPgeView({super.key, required this.ontap, required this.user});
  final VoidCallback ontap;
  final DoctorModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 180.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyColor, width: 2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Stack(
          children: [
            Container(
              height: 130.h,
              width: 170.w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(13),
                  topRight: Radius.circular(13),
                  bottomRight: Radius.circular(40),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      user.photo ?? StringConstants.dummyProfilePicture),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "${user.firstname} ${user.lastname}",
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "${user.specialist}",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
