import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:infinite_carousel/infinite_carousel.dart';

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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Top Doctor"),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            height: Get.height * .3,
            child: InfiniteCarousel.builder(
              itemCount: 5,
              controller: controller,
              itemExtent: 150,
              onIndexChanged: (p0) {
                setState(() {
                  index = p0;
                });
              },
              itemBuilder: (context, itemIndex, realIndex) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: CustomPgeView(),
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
      ),
    );
  }
}

class CustomPgeView extends StatelessWidget {
  const CustomPgeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: Get.height * .3,
      // width: Get.width * .3,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyColor, width: 2),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
      ]),
    );
  }
}
