import 'package:flutter/material.dart';

import '../constant/appcolor.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utlis/responsive_ui.dart';

class AppTextField extends StatelessWidget {
  final String? errorMessage;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  final int? maxLines;
  final int? maxLength;
  final bool? filled;
  final bool? min;
  final String labelText;

  final TextInputType? textInputType;

  const AppTextField(
      {super.key,
      this.errorMessage,
      this.controller,
      this.onChanged,
      this.filled,
      this.maxLength,
      this.hintText,
      required this.labelText,
      this.textInputType,
      this.min = false,
      this.maxLines});

  OutlineInputBorder border() => OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        borderSide: BorderSide(width: 1.w),
      );

  OutlineInputBorder errorBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.r)),
        borderSide: BorderSide(width: 1.w, color: AppColor.errorColor),
      );

  @override
  Widget build(BuildContext context) {
    final sh = sHeight(context);
    return Stack(
      children: [
        Container(
          padding:
              const EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 15),
          child: TextField(
            onChanged: onChanged,
            controller: controller,
            maxLength: maxLength,
            maxLines: maxLines,
            keyboardType: textInputType == null
                ? TextInputType.text
                : TextInputType.number,
            decoration: InputDecoration(
              fillColor: const Color(0xffFBFBFB),
              filled: filled,
              errorText: errorMessage == "" || errorMessage == null
                  ? null
                  : errorMessage,
              errorStyle: TextStyle(fontSize: sh(12)),
              // border: border(),
              focusedBorder: border(),
              enabledBorder: border(),
              errorBorder: errorBorder(),
            ),
          ),
        ),
        Positioned(
          top: -0.2,
          left: min == false ? 35 : 50,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            color: Colors.white,
            child: Text(
              labelText,
              style: const TextStyle(
                fontSize: 20,
                color: AppColor.blackColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
