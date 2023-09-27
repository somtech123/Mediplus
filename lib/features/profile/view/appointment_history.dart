import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mediplus/features/profile/view/review.dart';
import 'package:mediplus/features/profile/view/track_appointment.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/services/user/usecase.dart';
import '../../../core/utlis/shimmer_manager.dart';
import '../../dashboard/widget/empty_box.dart';
import '../../dashboard/widget/sub_widget/custom_tab.dart';
import '../widgets/appointment_tile.dart';

class AppointmentHistory extends StatefulWidget {
  const AppointmentHistory({super.key});

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory>
    with SingleTickerProviderStateMixin {
  final UserServices _userServices = UserServices();
  TabController? controller;
  int tabIndex = 0;

  @override
  void initState() {
    controller = TabController(length: 5, vsync: this);

    controller!.addListener(() {
      tabIndex = controller!.animation!.value.round();
    });
    super.initState();
  }

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
          "My Appointment",
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: AppColor.blackColor, fontSize: 15),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 15.h),
        child: Column(
          children: [
            Flexible(
              child: TabBar(
                tabs: [
                  CustomTab(
                    text: 'All',
                    index: 0,
                    tabIndex: tabIndex,
                  ),
                  CustomTab(
                    text: 'Upcoming',
                    index: 1,
                    tabIndex: tabIndex,
                  ),
                  CustomTab(
                    text: 'Accepted',
                    index: 2,
                    tabIndex: tabIndex,
                  ),
                  CustomTab(
                    text: 'Past',
                    index: 3,
                    tabIndex: tabIndex,
                  ),
                  CustomTab(
                    text: 'Declined',
                    index: 4,
                    tabIndex: tabIndex,
                  )
                ],
                isScrollable: true,
                controller: controller,
                indicator: const BoxDecoration(),
                onTap: (value) {
                  setState(() {
                    tabIndex = value;
                  });
                },
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              flex: 5,
              child: TabBarView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  allAppointmentHistory(context),
                  upcomingAppointmentHistory(context),
                  acceptedAppointment(context),
                  completedAppointment(context),
                  declinedAppointment(context),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget allAppointmentHistory(BuildContext context) {
    return FutureBuilder(
      future: _userServices.getAppointmentHistory(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: ShimmerManager.sectionShimmer(context),
            height: 200.h,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          if (data.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppointmentTile(appointment: data[index], onTap: () {}),
              ),
              itemCount: data.length,
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget upcomingAppointmentHistory(BuildContext context) {
    return FutureBuilder(
      future: _userServices.upComingAppointments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: ShimmerManager.sectionShimmer(context),
            height: 200.h,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          if (data.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppointmentTile(appointment: data[index], onTap: () {}),
              ),
              itemCount: data.length,
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget acceptedAppointment(BuildContext context) {
    return FutureBuilder(
      future: _userServices.sortAppointmentBySatus(status: 'accepted'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: ShimmerManager.sectionShimmer(context),
            height: 200.h,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          if (data.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppointmentTile(
                  appointment: data[index],
                  onTap: () =>
                      Get.to(() => TrackAppointment(appointment: data[index])),
                ),
              ),
              itemCount: data.length,
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget completedAppointment(BuildContext context) {
    return FutureBuilder(
      future: _userServices.sortAppointmentBySatus(status: 'completed'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: ShimmerManager.sectionShimmer(context),
            height: 200.h,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          if (data.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppointmentTile(
                  appointment: data[index],
                  onTap: () =>
                      Get.to(() => ReviewScreen(), arguments: data[index]),
                ),
              ),
              itemCount: data.length,
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget declinedAppointment(BuildContext context) {
    return FutureBuilder(
      future: _userServices.sortAppointmentBySatus(status: 'declined'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            child: ShimmerManager.sectionShimmer(context),
            height: 200.h,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
            ),
          );
        } else if (snapshot.hasData) {
          var data = snapshot.data!;
          if (data.isEmpty) {
            return const SizedBox.shrink();
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppointmentTile(appointment: data[index], onTap: () {}),
              ),
              itemCount: data.length,
            );
          }
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
