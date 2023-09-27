import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/features/dashboard/widget/doctor_detail_tab.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/constant/string_constant.dart';
import '../../../core/services/chat/model/chat_user_model.dart';
import '../../../core/services/user/usecase.dart';
import '../../../core/shared_widgets/primary_button.dart';
import '../../../core/shared_widgets/snack_bar.dart';
import '../../../core/utlis/utlis.dart';
import '../../chat/screen/view_layout.dart';
import '../controller/doctor_detail_controller.dart';

// ignore: must_be_immutable
class DoctorDetailPage extends StatelessWidget {
  DoctorDetailPage({super.key});
  var ctr = Get.put(DoctorDetailController());

  final UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColor.secondary,
          iconTheme: const IconThemeData(color: AppColor.blackColor),
          title: Text("Doctor Profile",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColor.blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500)),
          actions: [
            _favouriteDoc(context),
            Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () {
                    Share.share('${ctr.doc.firstname}, ${ctr.doc.lastname}');
                  },
                  icon: const Icon(
                    Icons.share,
                    color: AppColor.primaryColor,
                  ),
                )),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.dm),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60.w * 2,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: NetworkImage(ctr.doc.photo ??
                                StringConstants.dummyProfilePicture),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Doctor ${ctr.doc.firstname} ${ctr.doc.lastname}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: AppColor.blackColor),
                          ),
                          Text(
                            '${ctr.doc.specialist}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontSize: 14),
                          ),
                          _ratingBar(context,
                              rating: double.parse('${ctr.doc.rating}')),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _greyContainer(context,
                        heading: 'Patient',
                        subHeading: Utils.formatNumber(
                            int.parse('${ctr.doc.patient}'))),
                    _greyContainer(context,
                        heading: 'Experiences',
                        subHeading:
                            '${ctr.calculateYear(ctr.doc.experience!)} years'),
                    StreamBuilder(
                      stream:
                          _userServices.fetchDoctorReview(docId: ctr.doc.id),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          var docList = snapshot.data!.docs;

                          if (docList.isEmpty) {
                            return _greyContainer(context,
                                heading: 'Reviews',
                                subHeading: Utils.formatNumber(docList.length));
                          } else {
                            return _greyContainer(context,
                                heading: 'Reviews',
                                subHeading: Utils.formatNumber(docList.length));
                          }
                        } else if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }
                        return SizedBox();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GreyButton(
                        ontap: () {
                          ctr.launchPhoneDialer();
                        },
                        text: 'Audio call',
                        icon: const Icon(
                          Icons.call,
                          color: AppColor.primaryColor,
                        )),
                    GreyButton(
                        ontap: () {
                          showNoticeSnackBar('video call', 'coming soon');
                        },
                        text: 'video call',
                        icon: const Icon(
                          Icons.duo,
                          color: AppColor.primaryColor,
                        )),
                    GreyButton(
                      ontap: () {
                        Get.to(() => ViewLayout(
                              receiver: ChatUserModel(
                                userId: ctr.doc.id,
                                userName: ctr.doc.firstname,
                                firstname: ctr.doc.firstname,
                                lastname: ctr.doc.lastname,
                                phone: ctr.doc.phone,
                                profileUrl: ctr.doc.photo,
                              ),
                            ));
                      },
                      text: 'message',
                      icon: SvgPicture.asset(
                        "assets/svgs/chat-bubble-icon.svg",
                        color: AppColor.primaryColor,
                        height: 20.h,
                      ),
                    ),
                  ],
                ),
                const DoctorDetailTabWidget()
              ],
            ),
          ),
        )
        //),
        );
  }

  Widget _favouriteDoc(BuildContext context) {
    return StreamBuilder(
      stream: _userServices.fetchFavourite(
          userId: ctr.globalCtr.user.value.id, receiverId: ctr.doc.id),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        } else {
          var isFavorite = snapshot.data!['isFvourite'];
          return IconButton(
            onPressed: () => _userServices.toogleFavourite(
                userId: ctr.globalCtr.user.value.id,
                receiverId: ctr.doc.id,
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
    );
  }

  Widget _ratingBar(BuildContext context, {required double rating}) {
    // bool isRated = false;
    return RatingBar.builder(
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColor.rating,
      ),
      initialRating: double.parse('5'),
      minRating: 0,
      maxRating: 5,
      itemSize: 15.h,
      ignoreGestures: true,
      onRatingUpdate: (value) {},
    );
  }

  Widget _greyContainer(BuildContext context,
      {required String heading, required String subHeading}) {
    return Container(
      height: 45.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColor.greyWithOPacity,
        borderRadius: BorderRadius.all(
          Radius.circular(5.dm),
        ),
      ),
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
          text: heading,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 16,
                color: AppColor.blackColor,
                fontWeight: FontWeight.w500,
              ),
          children: [
            TextSpan(
              text: "\n$subHeading",
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16,
                    color: AppColor.primaryColor,
                    fontWeight: FontWeight.w500,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
