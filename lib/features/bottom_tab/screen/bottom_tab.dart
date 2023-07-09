import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../../core/constant/appcolor.dart';
import '../../appointment/appointment.dart';
import '../../chat/screen/chat.dart';
import '../../dashboard/screen/dashboard.dart';
import '../../profile/view/profile.dart';
import '../../search/search.dart';
import '../controller/bottom_tab_controller.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  var ctr = Get.put(BottomTabController());

  final List<Widget> _buildScreen = const [
    Dashboard(),
    SearchScreen(),
    // AppointMentScreen(),
    ChatScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: _buildScreen[ctr.tabIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: ctr.tabIndex.value,
            onTap: (value) {
              ctr.tabIndex.value = value;
              debugPrint(value.toString());
            },
            items: _navBarsItem(),
            selectedLabelStyle: TextStyle(fontSize: 10.sp),
            unselectedLabelStyle:
                TextStyle(fontSize: 12.sp, color: AppColor.blackColor),
            selectedItemColor: AppColor.primaryColor,
            unselectedItemColor: Color.fromARGB(255, 9, 5, 5),
            backgroundColor: AppColor.secondary,
            showUnselectedLabels: true,
            iconSize: 30.h,
          )),
    );
  }

  List<BottomNavigationBarItem> _navBarsItem() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/svgs/home.svg",
          color: ctr.tabIndex.value == 0
              ? AppColor.primaryColor
              : AppColor.greyColor,
          height: 20.h,
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "assets/svgs/search-icon.svg",
          color: ctr.tabIndex.value == 1
              ? AppColor.primaryColor
              : AppColor.greyColor,
          height: 20.h,
        ),
        label: "Search",
      ),
      // BottomNavigationBarItem(
      //     icon: SvgPicture.asset(
      //       "assets/svgs/calender-icon.svg",
      //       height: 20.h,
      //       color: ctr.tabIndex.value == 2
      //           ? AppColor.primaryColor
      //           : AppColor.greyColor,
      //     ),
      //     label: "Appointment"),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svgs/chat-bubble-icon.svg",
            color: ctr.tabIndex.value == 2
                ? AppColor.primaryColor
                : AppColor.greyColor,
            height: 20.h,
          ),
          label: "Chat"),
      BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/svgs/profile-circle.svg",
            color: ctr.tabIndex.value == 3
                ? AppColor.primaryColor
                : AppColor.greyColor,
            height: 20.h,
          ),
          label: "Profile"),
    ];
  }
}
