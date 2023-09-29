import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/features/dashboard/widget/empty_box.dart';

import '../../../core/constant/string_constant.dart';
import '../../../core/gloalctr.dart';
import '../../../core/services/user/model/doctor_model.dart';
import '../../../core/services/user/model/favourite_model.dart';
import '../../../core/services/user/usecase.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../widget/bottom_sheet.dart';

// ignore: must_be_immutable
class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({super.key});

  final UserServices _userServices = UserServices();

  var globalCtr = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        elevation: 0,
        title: Text("Favourite Doctors",
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColor.blackColor,
                fontSize: 15,
                fontWeight: FontWeight.w500)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
      ),
      body: StreamBuilder(
        stream:
            _userServices.fetchallFavourite(userId: globalCtr.user.value.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var docList = snapshot.data!.docs;

            if (docList.isEmpty) {
              return EmptyBox(
                text: 'Sorry you have no favourite doctor',
              );
            } else {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    FavouriteModel _fav =
                        FavouriteModel.fromJson(docList[index].data());

                    return layout(context, favouriteDoc: _fav);
                  },
                  itemCount: docList.length);
            }
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Could not get favourite doctor at the moment'));
          }
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ShimmerManager.textShimmer(context));
        },
      ),
    );
  }

  Widget layout(BuildContext context, {required FavouriteModel favouriteDoc}) {
    return FutureBuilder<DoctorModel>(
      future: _userServices.getDoctorById(favouriteDoc.receiverID),
      builder: (context, AsyncSnapshot<DoctorModel> snapshot) {
        if (snapshot.hasData) {
          DoctorModel user = snapshot.data!;

          return _favDocTile(context, user: user);
        } else if (snapshot.hasError) {
          debugPrint('${snapshot.error}');
        }
        return Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: ShimmerManager.textShimmer(context),
        );
      },
    );
  }

  Widget _favDocTile(
    BuildContext context, {
    required DoctorModel user,
    // required VoidCallback ontap
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      child: GestureDetector(
        // onTap: ontap,
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
                    userId: globalCtr.user.value.id, receiverId: user.id),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    var isFavorite = snapshot.data!['isFvourite'];
                    return IconButton(
                      onPressed: () => customBottomSheet(context,
                          yesTap: () {
                            _userServices.toogleFavourite(
                                userId: globalCtr.user.value.id,
                                receiverId: user.id,
                                isFavourite: !isFavorite);
                            Get.back();
                          },
                          noTap: () => Get.back(),
                          user: user),
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
      ),
    );
  }
}
