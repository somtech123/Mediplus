import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        elevation: 0,
        title: Text(
          "Favourite",
          style: TextStyle(color: AppColor.blackColor),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.blackColor),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('')
              // buildFvouriteCard(context),
              ),
          separatorBuilder: (_, __) => SizedBox(
                height: 18.h,
              ),
          itemCount: 15),
    );
  }
}

Widget buildFvouriteCard(BuildContext context) {
  return Container(
    height: 80.h,
    width: Get.width,
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
            image: DecorationImage(
              image: AssetImage("assets/images/doc1.jpg"),
            ),
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        _buidDoctorInfo(context),
        Container(
          width: 35.w,
          height: 30.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.lightBlue,
          ),
          child: const Icon(
            Icons.favorite,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    ),
  );
}

Widget _buidDoctorInfo(BuildContext context) {
  return Flexible(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Doctor Chisom Onyenacho"),
        SizedBox(
          height: 30,
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
                  itemCount: 5,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Text("5.0"),
              Text("(5500)")
            ],
          ),
        ),
        Text("Dentist -University of Compton")
      ],
    ),
  );
}
