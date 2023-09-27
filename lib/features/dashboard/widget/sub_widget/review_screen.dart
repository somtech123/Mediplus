import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';

import '../../../../core/constant/string_constant.dart';
import '../../../../core/services/user/model/review_model.dart';
import '../../../../core/services/user/usecase.dart';
import '../../../../core/utlis/shimmer_manager.dart';
import '../../controller/doctor_detail_controller.dart';

// ignore: must_be_immutable
class ReviewWidget extends StatelessWidget {
  ReviewWidget({super.key});

  var ctr = Get.find<DoctorDetailController>();

  final UserServices _userServices = UserServices();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: _userServices.fetchDoctorReview(docId: ctr.doc.id),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            var docList = snapshot.data!.docs;

            if (docList.isEmpty) {
              return const SizedBox.shrink();
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Review (${docList.length})',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: AppColor.blackColor,
                        ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemBuilder: (context, index) {
                          ReviewModel _review =
                              ReviewModel.fromJson(docList[index].data());
                          return _layout(context, review: _review);
                        },
                        itemCount: docList.length),
                  )
                ],
              );
            }
          } else if (snapshot.hasError) {
            return const Center(
                child: Text('Could not get doctor review at the moment'));
          }
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ShimmerManager.textShimmer(context));
        },
      ),
    );
  }

  Widget _layout(BuildContext context, {required ReviewModel review}) {
    return Padding(
      padding: EdgeInsets.only(top: 15.h),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          maxRadius: 30,
          backgroundImage:
              NetworkImage(review.photo ?? StringConstants.dummyProfilePicture),
        ),
        title: Text(
          '${review.firstname} ${review.lastname}',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 15,
              color: AppColor.blackColor,
              fontWeight: FontWeight.w600),
        ),
        trailing: _ratingBar(context, rating: '${review.rating}'),
        subtitle: Text(
          '${review.comment}',
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _ratingBar(BuildContext context, {required String rating}) {
    // bool isRated = false;
    return RatingBar.builder(
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: AppColor.rating,
      ),
      initialRating: double.parse(rating),
      minRating: 0,
      maxRating: 5,
      itemSize: 15.h,
      ignoreGestures: true,
      onRatingUpdate: (value) {},
    );
  }
}
