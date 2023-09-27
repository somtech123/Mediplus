import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/services/user/usecase.dart';
import 'package:mediplus/features/search/controller/search_controller.dart';

import '../../core/constant/appcolor.dart';
import '../../core/constant/string_constant.dart';
import '../../core/services/user/model/doctor_model.dart';
import '../../core/shared_widgets/custom_textfield.dart';
import '../dashboard/screen/doctor_detail.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  var ctr = Get.put(ExploreController());
  final UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.secondary,
        title: const Text(
          "Explore",
          style: TextStyle(color: AppColor.blackColor, fontSize: 20),
        ),
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
                            child: _searchDoctorInfo(
                              context,
                              user: ctr.user[index],
                              ontap: () {
                                Get.to(() => DoctorDetailPage(),
                                    arguments: ctr.user[index]);
                              },
                            )),
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

  Widget _searchDoctorInfo(BuildContext context,
      {required DoctorModel user, required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
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
            StreamBuilder(
              stream: _userServices.fetchFavourite(
                  userId: ctr.globalCtr.user.value.id, receiverId: user.id),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  var isFavorite = snapshot.data!['isFvourite'];
                  return IconButton(
                    onPressed: () => _userServices.toogleFavourite(
                        userId: ctr.globalCtr.user.value.id,
                        receiverId: user.id,
                        isFavourite: !isFavorite),
                    icon: Icon(
                      Icons.favorite,
                      color: isFavorite == false
                          ? AppColor.greyColor
                          : AppColor.primaryColor,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
