import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constant/appcolor.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: SizedBox(
        width: Get.width,
        child: Row(
          children: [
            const Expanded(
              child: Divider(
                height: 10,
                thickness: 1.5,
                color: AppColor.blackColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "Or Continue With",
                style: Theme.of(context).textTheme.button!.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: AppColor.blackColor),
              ),
            ),
            const Expanded(
              child: Divider(
                height: 10,
                thickness: 1.5,
                color: AppColor.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
