import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mediplus/core/constant/appcolor.dart';

class DashboardBanner extends StatelessWidget {
  const DashboardBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 120.h,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                    Text("Looking for your Dentist"),
                    Text("Specialist Doctor?"),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text("Doctor Oscar"),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => SvgPicture.asset(
                          "assets/svgs/rating-full-icon.svg",
                          color: AppColor.ratingColor,
                          height: 15,
                        ),
                        itemCount: 5,
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
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/doc1.jpg"))),
              )
            ],
          ),
        )
      ],
    );
  }
}
