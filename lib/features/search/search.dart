import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../core/constant/appcolor.dart';
import '../../core/shared_widgets/custom_textfield.dart';
import '../dashboard/screen/tab/favourite_screen.dart';
import '../dashboard/widget/dashboard_banner.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        elevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Select Field",
              style: TextStyle(color: AppColor.blackColor),
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.blackColor),
      ),
      body: SingleChildScrollView(
        child:
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            //   child:
            Column(
          //  mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: CustomBorderTextField(
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
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Text("Specialist"),
            ),
            Container(
              height: Get.height * .5,
              child: ListView.separated(
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: buildFvouriteCard(context),
                      ),
                  shrinkWrap: true,
                  separatorBuilder: (_, __) => SizedBox(
                        height: 18.h,
                      ),
                  itemCount: 15),
            ),
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Text("Available Doctors"),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: SizedBox(
                height: 300.h,
                child: ListView.builder(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: DashboardBanner(),
                  ),
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
          ],
        ),
      ),
      //),
    );
  }
}
