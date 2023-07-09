import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediplus/features/splash/screen/splash_screen.dart';

import 'core/constant/appcolor.dart';
import 'core/route/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) => GetMaterialApp(
        title: 'MediPlus',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: GoogleFonts.dmSans().fontFamily,
            scaffoldBackgroundColor: AppColor.secondary),
        smartManagement: SmartManagement.keepFactory,
        getPages: AppRoutes.appPages,
        home: SplashScreen(),
      ),
    );
  }
}
