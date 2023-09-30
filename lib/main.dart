import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediplus/core/gloalctr.dart';
import 'package:mediplus/env/private_key.dart';
import 'package:mediplus/features/splash/screen/splash_screen.dart';

import 'core/constant/appcolor.dart';
import 'core/route/routes.dart';
import 'core/services/notification/usecase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = PrivateKey.stripePublicKey;
  LocalNotificationService.initialize();

  await Stripe.instance.applySettings();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});

  var ctr = Get.put(GlobalController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
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
