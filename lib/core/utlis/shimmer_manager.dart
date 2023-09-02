import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mediplus/core/utlis/responsive_ui.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerManager {
  ShimmerManager._();

  static sectionShimmer(BuildContext context, {double? height = 150}) {
    final h = sHeight(context);
    // final w = sWidth(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Shimmer.fromColors(
        baseColor: Get.isDarkMode ? Colors.grey[400]! : Colors.grey[100]!,
        highlightColor: Get.isDarkMode ? Colors.grey[700]! : Colors.grey[500]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Get.isDarkMode ? Colors.grey[500]! : Colors.grey[400],
          ),
          height: h(height),
          width: Get.width,
        ),
      ),
    );
  }

  static roundedShimmer(BuildContext context, {double? size = 50}) {
    final h = sHeight(context);
    // final w = sWidth(context);
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: Shimmer.fromColors(
        baseColor: Get.isDarkMode ? Colors.grey[400]! : Colors.grey[100]!,
        highlightColor: Get.isDarkMode ? Colors.grey[700]! : Colors.grey[500]!,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Get.isDarkMode ? Colors.grey[500]! : Colors.grey[400],
          ),
          height: h(size),
          width: h(size),
        ),
      ),
    );
  }

  static textShimmer(BuildContext context, {double? height = 50}) {
    final h = sHeight(context);
    return Shimmer.fromColors(
      baseColor: Get.isDarkMode ? Colors.grey[400]! : Colors.grey[100]!,
      highlightColor: Get.isDarkMode ? Colors.grey[700]! : Colors.grey[500]!,
      child: Container(
        width: Get.width,
        color: Get.isDarkMode ? Colors.grey[500]! : Colors.grey[400],
        height: h(height),
      ),
    );
  }
}
