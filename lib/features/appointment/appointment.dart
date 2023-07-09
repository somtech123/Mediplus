import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_event_calendar/flutter_event_calendar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/constant/appcolor.dart';

class AppoinmentScreen extends StatelessWidget {
  const AppoinmentScreen({super.key});

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Column(
                children: [
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.greyColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //  crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          height: 150.h * 2,
                          width: 80.w * 2,
                          child: Image.asset(
                            'assets/images/doc1.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Consultation fee"),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  'assets/svgs/nigeria-naira-icon.svg',
                                  height: 15,
                                  color: AppColor.primaryColor,
                                ),
                                Text(" 67, 00")
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  EventCalendar(
                    calendarType: CalendarType.GREGORIAN,
                    calendarLanguage: 'en',
                    calendarOptions: CalendarOptions(
                      viewType: ViewType.DAILY,
                    ),
                    eventOptions: EventOptions(),
                    dayOptions: DayOptions(),

                    // events: [
                    //   Event(
                    //     child: const Text('Laravel Event'),
                    //     dateTime: CalendarDateTime(
                    //       year: 1401,
                    //       month: 5,
                    //       day: 12,
                    //       calendarType: CalendarType.GREGORIAN,
                    //     ),
                    //   ),
                    // ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
