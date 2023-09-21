import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/constant/appcolor.dart';
import 'package:mediplus/core/constant/string_constant.dart';
import 'package:mediplus/core/shared_widgets/app_textfield.dart';
import 'package:mediplus/core/shared_widgets/custom_textfield.dart';
import 'package:mediplus/core/shared_widgets/primary_button.dart';
import 'package:mediplus/features/dashboard/controller/patient_info_controller.dart';
import 'package:mediplus/features/dashboard/screen/payment_screen.dart';

// ignore: must_be_immutable
class PatientInfoScreen extends StatelessWidget {
  PatientInfoScreen({super.key});

  var ctr = Get.put(PatientInfoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: const Text(
          "Visit Info",
          style: TextStyle(color: AppColor.blackColor, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Column(
            children: [
              SizedBox(height: 20.h),
              AppTextField(
                labelText: 'Patient name',
                min: true,
                controller: ctr.nameController,
                errorMessage: ctr.nameErrorText.value,
                onChanged: (p) => ctr.clearError(ctr.nameErrorText),
              ),
              InkWell(
                onTap: () => ctr.selectDate(context),
                child: AbsorbPointer(
                  absorbing: true,
                  child: AppTextField(
                    labelText: 'Date of birth',
                    min: true,
                    controller: ctr.dateController,
                    errorMessage: ctr.dateErrorText.value,
                    onChanged: (p0) => ctr.clearError(ctr.dateErrorText),
                    suffix: const Icon(Icons.calendar_month,
                        size: 16, color: AppColor.blackColor),
                  ),
                ),
              ),
              AppTextField(
                labelText: 'Weight (KG)',
                min: true,
                controller: ctr.weightController,
                errorMessage: ctr.weightErrorText.value,
                onChanged: (p0) => ctr.clearError(ctr.weightErrorText),
                textInputType: TextInputType.number,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: CustomBorderTextField(
                  maxLines: 10,
                  hintText: 'Briefy describe your problem',
                  controller: ctr.descriptionController,
                  errorMessage: ctr.descriptionErrorText.value,
                  onChanged: (p0) => ctr.clearError(ctr.descriptionErrorText),
                ),
              ),
              SizedBox(height: 10.h),
              _dottedContainer(
                context,
                ontap: () => ctr.pickMultipleFile(),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                child: PrimaryButton(
                    label: 'Proceed',
                    onPressed: () {
                      ctr.validateInput();
                    }),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dottedContainer(BuildContext context, {required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        child: DottedBorder(
          color: AppColor.primaryColor,
          strokeWidth: 1,
          child: CustomPaint(
            painter: EdgePainter(),
            child: Container(
              height: 100.h,
              width: Get.width,
              padding: const EdgeInsets.only(
                  left: 20, right: 10, bottom: 20, top: 10),
              child: Stack(
                children: [
                  Obx(() => ctr.file.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                  text: "Attach report and previous",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: AppColor.greyColor),
                                  children: const [
                                    TextSpan(text: "\nPrescription"),
                                  ]),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              StringConstants.attachmentString,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: AppColor.greyColor),
                            )
                          ],
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) =>
                              Text(ctr.file[index].name),
                          itemCount: ctr.file.length,
                        )),
                  const Positioned(
                    right: 5,
                    child: Icon(
                      Icons.cloud_upload,
                      color: AppColor.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EdgePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColor.primaryColor
      ..strokeWidth = 2.0;

    final curveHeight = size.height * 0.55;
    final curveWidth = size.width * 0.85;

    final path = Path()
      ..moveTo(size.width, 0)
      ..lineTo(230, 0)
      ..quadraticBezierTo(
        curveWidth,
        curveHeight,
        size.width,
        curveHeight,
      );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
