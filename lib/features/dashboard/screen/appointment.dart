import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mediplus/core/shared_widgets/primary_button.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/constant/string_constant.dart';
import '../../../core/utlis/utlis.dart';
import '../controller/appointment_controller.dart';
import '../widget/custom_container.dart';

// ignore: must_be_immutable
class AppoinmentScreen extends StatelessWidget {
  AppoinmentScreen({super.key});
  var ctr = Get.put(AppointmentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: const Text(
          "Appointment",
          style: TextStyle(color: AppColor.blackColor, fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    // AppColor.greyWithOPacity,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      SizedBox(
                        width: 30.w,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Consultation fee",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/svgs/nigeria-naira-icon.svg',
                                height: 15,
                                color: AppColor.primaryColor,
                              ),
                              Text(
                                " ${currencyFormat.format(double.parse(ctr.doc.fee!))}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  DateFormat('MMMM').format(DateTime.now()),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.h),
                DatePicker(DateTime.now(),
                    height: 80.h,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: AppColor.primaryColor,
                    selectedTextColor: Colors.white,
                    onDateChange: (date) => ctr.selectDate(date)),
                SizedBox(height: 20.h),
                Text(
                  'Morning Slots',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.h),
                Wrap(
                  children: List.generate(ctr.doc.morningSlot!.length, (index) {
                    String time = ctr.getTime(
                        time: TimeOfDay(
                            hour: ctr.doc.morningSlot![index].hour!,
                            minute: ctr.doc.morningSlot![index].minutes!));
                    final TimeOfDay _selectedTime = TimeOfDay(
                        hour: ctr.doc.morningSlot![index].hour!,
                        minute: ctr.doc.morningSlot![index].minutes!);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTimeContainer(
                        ontap: () {
                          ctr.onTimeSelected(_selectedTime);
                        },
                        time: time,
                        isActive: ctr.isTimeSelected(_selectedTime),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Afternoon Slots',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.h),
                Wrap(
                  children: List.generate(ctr.doc.noonSlot!.length, (index) {
                    String time = ctr.getTime(
                        time: TimeOfDay(
                            hour: ctr.doc.noonSlot![index].hour!,
                            minute: ctr.doc.noonSlot![index].minutes!));
                    TimeOfDay _selectedTime = TimeOfDay(
                        hour: ctr.doc.noonSlot![index].hour!,
                        minute: ctr.doc.noonSlot![index].minutes!);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTimeContainer(
                          ontap: () => ctr.onTimeSelected(_selectedTime),
                          time: time,
                          isActive: ctr.isTimeSelected(_selectedTime)),
                    );
                  }),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Evening Slots',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20.h),
                Wrap(
                  children: List.generate(ctr.doc.nightSlot!.length, (index) {
                    String time = ctr.getTime(
                        time: TimeOfDay(
                            hour: ctr.doc.nightSlot![index].hour!,
                            minute: ctr.doc.nightSlot![index].minutes!));
                    TimeOfDay _time = TimeOfDay(
                        hour: ctr.doc.nightSlot![index].hour!,
                        minute: ctr.doc.nightSlot![index].minutes!);
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTimeContainer(
                          ontap: () => ctr.onTimeSelected(_time),
                          time: time,
                          isActive: ctr.isTimeSelected(_time)),
                    );
                  }),
                ),
                SizedBox(height: 20.h),
                PrimaryButton(
                    label: 'Proceed',
                    onPressed: () {
                      ctr.validate();
                    }),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
