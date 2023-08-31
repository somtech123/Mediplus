import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/appcolor.dart';
import '../utlis/responsive_ui.dart';

class CustomBorderTextField extends StatelessWidget {
  CustomBorderTextField(
      {Key? key,
      this.header,
      this.hintText,
      this.maxLines,
      this.filled,
      this.hasBorder = true,
      this.isPrefix,
      this.prefix,
      this.hintStyle,
      this.headerStyle,
      this.boxConstraints,
      this.controller,
      this.onChanged,
      this.errorMessage,
      this.readOnly,
      this.textInputType,
      this.enable = true,
      this.textInputFormat,
      this.maxLength,
      this.obscureText = false,
      this.suffix,
      this.isSuffix})
      : super(key: key);
  final String? header;
  final String? hintText;
  final int? maxLines;
  final int? maxLength;
  final bool? filled;
  final bool? isPrefix;
  final bool? isSuffix;
  // if isPrefix is false then isSuffix is true
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? errorMessage;
  final bool? hasBorder;
  final TextInputType? textInputType;
  final Widget? prefix;
  final Widget? suffix;

  final bool obscureText;
  final TextStyle? hintStyle;
  final TextStyle? headerStyle;
  final bool? enable;
  final bool? readOnly;
  final BoxConstraints? boxConstraints;
  final List<TextInputFormatter>? textInputFormat;

  @override
  Widget build(BuildContext context) {
    final sh = sHeight(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header ?? '',
          style: headerStyle ?? Theme.of(context).textTheme.caption,
        ),
        TextFormField(
          inputFormatters: textInputFormat,
          controller: controller,
          onChanged: onChanged,
          maxLines: maxLines,
          enabled: enable,
          maxLength: maxLength,
          obscureText: obscureText,
          keyboardType:
              textInputType == null ? TextInputType.text : TextInputType.number,
          readOnly: readOnly == null ? false : true,
          decoration: InputDecoration(
            prefixIcon: prefix,
            fillColor: const Color(0xffFBFBFB),
            suffixIcon: suffix,
            filled: filled,
            errorText: errorMessage == "" || errorMessage == null
                ? null
                : errorMessage,
            errorStyle: TextStyle(fontSize: sh(12)),
            hintText: hintText,
            hintStyle: hintStyle ??
                Theme.of(context).textTheme.caption!.copyWith(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColor.greyColor),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: hasBorder == true
                    ? BorderSide(color: const Color(0xffBDBDBD), width: 1.w)
                    : BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: hasBorder == true
                    ? BorderSide(
                        color: const Color(0xffBDBDBD),
                        width: 1.w,
                      )
                    : BorderSide.none),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: hasBorder == true
                  ? BorderSide(color: Colors.red, width: 1.w)
                  : BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
