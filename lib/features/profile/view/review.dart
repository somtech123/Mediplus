import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/constant/string_constant.dart';
import '../../../core/services/user/model/appointment_model.dart';
import '../../../core/shared_widgets/custom_textfield.dart';
import '../../../core/shared_widgets/primary_button.dart';
import '../controller/review_controller.dart';

// ignore: must_be_immutable
class ReviewScreen extends StatelessWidget {
  ReviewScreen({
    super.key,
  });
  //final AppointmentModel appointment;

  var ctr = Get.put(ReviewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.secondary,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: Text(
          "Review",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: AppColor.blackColor, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.h),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                CircleAvatar(
                    maxRadius: 60.r,
                    backgroundImage: NetworkImage(ctr.appointment.doctorPhoto ??
                        StringConstants.dummyProfilePicture)),
                SizedBox(height: 20.h),
                RichText(
                  text: TextSpan(
                      text: 'How was your experience with',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColor.blackColor),
                      children: [
                        TextSpan(
                          text:
                              "\n                  Dr ${ctr.appointment.doctorFirstName} ${ctr.appointment.doctorLastName}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor),
                        )
                      ]),
                ),
                SizedBox(height: 20.h),
                RatingBar.builder(
                    minRating: 1,
                    itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: AppColor.rating,
                        ),
                    updateOnDrag: true,
                    unratedColor: Colors.amber.withAlpha(50),
                    onRatingUpdate: (rating) {
                      ctr.rating.value = rating;
                    }),
                SizedBox(height: 20.h),
                CustomBorderTextField(
                  maxLines: 10,
                  hintText: 'Leave a Comment',
                  controller: ctr.commentController,
                  errorMessage: ctr.commentError.value,
                  onChanged: (p0) => ctr.clearError(ctr.commentError),
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                    label: 'Submit Review',
                    onPressed: () {
                      ctr.validate();
                    }),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
