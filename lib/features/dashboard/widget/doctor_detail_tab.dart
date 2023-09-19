import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/dashboard/widget/sub_widget/custom_tab.dart';
import 'package:mediplus/features/dashboard/widget/sub_widget/doc_info.dart';
import 'package:mediplus/features/dashboard/widget/sub_widget/review_screen.dart';

import '../controller/doctor_detail_controller.dart';
import 'sub_widget/doc_experience_widget.dart';

class DoctorDetailTabWidget extends StatefulWidget {
  const DoctorDetailTabWidget({super.key});

  @override
  State<DoctorDetailTabWidget> createState() => _DoctorDetailTabWidgetState();
}

class _DoctorDetailTabWidgetState extends State<DoctorDetailTabWidget>
    with SingleTickerProviderStateMixin {
  var ctr = Get.find<DoctorDetailController>();

  TabController? controller;
  int tabIndex = 0;

  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);

    controller!.addListener(() {
      tabIndex = controller!.animation!.value.round();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TabBar(
                tabs: [
                  CustomTab(
                    text: 'info',
                    index: 0,
                    tabIndex: tabIndex,
                  ),
                  CustomTab(
                    text: 'Experience',
                    index: 1,
                    tabIndex: tabIndex,
                  ),
                  CustomTab(
                    text: 'Review',
                    index: 2,
                    tabIndex: tabIndex,
                  )
                ],
                isScrollable: false,
                controller: controller,
                indicator: const BoxDecoration(),
                onTap: (value) {
                  setState(() {
                    tabIndex = value;
                  });
                },
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        SizedBox(
          height: Get.height,
          child: TabBarView(
            controller: controller,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DocInfo(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DocExperience(doc: ctr.doc),
                ],
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ReviewWidget(),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
