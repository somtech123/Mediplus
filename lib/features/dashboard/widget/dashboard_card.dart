import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

import 'doctor_detail.dart';

class DashboardCard extends StatefulWidget {
  DashboardCard({super.key});

  @override
  State<DashboardCard> createState() => _DashboardCardState();
}

class _DashboardCardState extends State<DashboardCard> {
  // PageController controller = PageController(initialPage: 0);
  late InfiniteScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = InfiniteScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  int index = 0;

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
        SizedBox(
          height: 200.h,
          child: InfiniteCarousel.builder(
            itemCount: 5,
            controller: controller,
            itemExtent: 200.w,
            onIndexChanged: (p0) {
              setState(() {
                index = p0;
              });
            },
            itemBuilder: (context, itemIndex, realIndex) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: CustomPgeView(
                ontap: () {
                  Get.to(() => DoctorDetailPage());
                },
              ),
            ),
          ),
        ),
        Center(
          child: Container(
              color: AppColor.secondary,
              height: 30.h,
              child: Column(children: [
                SizedBox(height: 10.h),
                DotsIndicator(
                  dotsCount: 5,
                  position: int.parse("$index"),
                  decorator: DotsDecorator(
                    color: AppColor.greyColor,
                    spacing: const EdgeInsets.symmetric(horizontal: 4.5),
                    activeColor: AppColor.primaryColor,
                    size: const Size.square(5.0),
                    activeSize: const Size.square(10.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                  ),
                ),
              ])),
        )
      ],
    );
  }
}

class CustomPgeView extends StatelessWidget {
  const CustomPgeView({super.key, required this.ontap});
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.greyColor, width: 2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130.h,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/doc1.jpg"),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("Doctor Chisom Onyenacho"),
              ),
              SizedBox(
                height: 10.h,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8),
                child: Text("Dental"),
              )
            ],
          )
        ],
      ),
    );
  }
}
