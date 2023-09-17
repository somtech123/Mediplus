import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/features/dashboard/controller/dashboard_controller.dart';
import 'package:mediplus/features/dashboard/widget/tab/favourite_screen.dart';

import '../../../core/shared_widgets/custom_textfield.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../widget/dashboard_banner.dart';
import '../widget/dashboard_card.dart';
import '../widget/feature_card.dart';

class Dashboard extends StatelessWidget {
  Dashboard({super.key});
  var ctr = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        elevation: 0,
        title: Padding(
          padding: EdgeInsets.only(left: 5.h),
          child: Text(
            "Hey, Oscar",
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: AppColor.blackColor, fontSize: 20.sp),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => FavouriteScreen()),
            child: Icon(
              Icons.favorite_border_outlined,
              color: AppColor.primaryColor,
              size: 30.sp,
            ),
          ),
          SizedBox(
            width: 15.w,
          ),
          GestureDetector(
            child: Icon(
              Icons.notifications_none,
              color: AppColor.primaryColor,
              size: 30.sp,
            ),
          ),
          SizedBox(
            width: 5.w,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70.h,
                width: Get.width,
                decoration: const BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Discover",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 20.sp, color: AppColor.secondary)),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text("Find your suitable doctor!",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  fontSize: 12.sp, color: AppColor.secondary))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              CustomBorderTextField(
                hasBorder: true,
                hintText: "Search",
                prefix: const Icon(
                  Icons.search,
                  color: AppColor.blackColor,
                ),
                suffix: const Icon(
                  Icons.menu,
                  color: AppColor.blackColor,
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              const FeatureCard(),
              SizedBox(
                height: 20.h,
              ),
              DashboardCard(),
              SizedBox(height: 20.h),
              Text(
                "Available Doctors",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              SizedBox(
                height: 20.h,
              ),
              FutureBuilder(
                future: ctr.getAllDoctors(),
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
                    return SizedBox(
                      height: 280.h,
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: DashboardBanner(
                            user: snapshot.data![index],
                          ),
                        ),
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
