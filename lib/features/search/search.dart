import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/search/controller/search_controller.dart';

import '../../core/constant/appcolor.dart';
import '../../core/constant/string_constant.dart';
import '../../core/services/user/model/doctor_model.dart';
import '../../core/shared_widgets/custom_textfield.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var ctr = Get.put(ExploreController());

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
        iconTheme: const IconThemeData(color: AppColor.blackColor),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: CustomBorderTextField(
              hasBorder: true,
              hintText: "Search",
              controller: ctr.searchController,
              onChanged: (query) => ctr.search(query),
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
          Obx(
            () => ctr.user.isEmpty
                ? Center(
                    child: Text(
                      'no result found for ${ctr.searchController.text}',
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  )
                : Expanded(
                    flex: 1,
                    child: ListView.separated(
                        itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: _searchDoctorInfo(context,
                                user: ctr.user[index])),
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => SizedBox(
                              height: 15.h,
                            ),
                        itemCount: ctr.user.length),
                  ),
          ),
          SizedBox(
            height: 15.h,
          ),
        ],
      ),
    );
  }

  Widget _searchDoctorInfo(BuildContext context, {required DoctorModel user}) {
    return Container(
      height: 80.h,
      width: Get.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(7),
              ),
              image: DecorationImage(
                  image: NetworkImage(
                      user.photo ?? StringConstants.dummyProfilePicture)),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Doctor ${user.firstname} ${user.lastname}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                ),
                SizedBox(
                  height: 15.h,
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
                          itemCount: int.parse('${user.rating}'),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "${user.specialist} -${user.hospital}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackColor,
                      ),
                  maxLines: 1,
                )
              ],
            ),
          ),
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
}
