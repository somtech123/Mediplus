import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/onboarding/screen/onboarding2.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared_widgets/primary_button.dart';
import '../controller/onboarding_controller.dart';
import '../model/onboarding_model.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnboardingScreen extends StatefulWidget {
  static String path = '/Onboarding';
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _index = 0;
  var ctr = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: Get.height * 0.7 + 100,
                  viewportFraction: 1.0,
                  enlargeCenterPage: false,
                  onPageChanged: (index, _) {
                    setState(() {
                      debugPrint(index.toString());
                      _index = index;
                    });
                  },
                ),
                items: ctr.onBoarding
                    .map((e) => CustomPage(onboardingModel: e))
                    .toList(),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        color: AppColor.secondary,
                        height: 30.h,
                        child: Column(children: [
                          SizedBox(height: 10.h),
                          DotsIndicator(
                            dotsCount: 3,
                            position: int.parse("$_index"),
                            decorator: DotsDecorator(
                              color: AppColor.greyColor,
                              spacing:
                                  const EdgeInsets.symmetric(horizontal: 4.5),
                              activeColor: AppColor.primaryColor,
                              size: const Size.square(5.0),
                              activeSize: const Size.square(10.0),
                              activeShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ])),
                    SizedBox(
                      width: 80.h,
                      height: 50.h,
                      child: SmallButton(
                        label: 'Next',
                        labelColor: AppColor.secondary,
                        onPressed: () {
                          Get.offAll(() => const OnboardingScreenTwo());
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomPage extends StatelessWidget {
  const CustomPage({super.key, required this.onboardingModel});
  final OnboardingModel onboardingModel;

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: h / 2 + 100,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(onboardingModel.imageUrl!),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(240.h),
            ),
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(onboardingModel.mainText!,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                      color: AppColor.blackColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10.h,
              ),
              Text(
                onboardingModel.subText!,
                maxLines: 2,
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: AppColor.greyColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
