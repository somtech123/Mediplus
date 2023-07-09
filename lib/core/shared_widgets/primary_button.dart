import 'package:flutter/material.dart';

import '../constant/appcolor.dart';
import '../constant/int_constant.dart';
import '../utlis/responsive_ui.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Function? onPressed;
  final Color? backgroundColor;
  final Color? accentColor;
  final Color? borderColor;
  bool hideBorder;
  final double? topLeftRadius;
  final double? topRightRadius;
  final double? bottomRightRadius;
  final double? bottomLeftRadius;

  PrimaryButton(
      {Key? key,
      required this.label,
      this.labelColor,
      required this.onPressed,
      this.backgroundColor,
      this.accentColor,
      this.hideBorder = false,
      this.borderColor,
      this.topLeftRadius,
      this.bottomLeftRadius,
      this.bottomRightRadius,
      this.topRightRadius
      // this.horizontalMargin,
      // this.verticalMargin,
      })
      : super(key: key);

  MaterialStateProperty<T> changeButtonStyle<T>(style) =>
      MaterialStateProperty.all<T>(style);

  @override
  Widget build(BuildContext context) {
    final fs = fullScreen(context);
    final h = sHeight(context);
    return
        // Container(
        //   height: btnHeight == null ? 52 : btnHeight,
        //   width: btnWidth == null ? double.infinity : btnWidth,
        // child:
        ElevatedButton(
      style: ButtonStyle(
        minimumSize: changeButtonStyle<Size>(Size(
          fs('width'),
          h(58.0),
        )),
        animationDuration: const Duration(
            microseconds: IntConstants.buttonSplashAnimationDuration),
        backgroundColor:
            changeButtonStyle<Color>(backgroundColor ?? AppColor.primaryColor),
        overlayColor: changeButtonStyle<Color>(
          accentColor ?? AppColor.buttonOverlay,
        ),
        shape: changeButtonStyle<OutlinedBorder>(
          hideBorder
              ? RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(topLeftRadius ?? 8.0),
                      bottomLeft: Radius.circular(bottomLeftRadius ?? 8.0),
                      bottomRight: Radius.circular(bottomRightRadius ?? 8.0),
                      topRight: Radius.circular(topRightRadius ?? 8.0)))
              : RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0, color: borderColor ?? Colors.transparent),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(topLeftRadius ?? 8.0),
                      bottomLeft: Radius.circular(bottomLeftRadius ?? 8.0),
                      bottomRight: Radius.circular(bottomRightRadius ?? 8.0),
                      topRight: Radius.circular(topRightRadius ?? 8.0))),
        ),
        elevation: changeButtonStyle<double>(0.0),
      ),
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: Text(
        label,
        style: Theme.of(context).textTheme.caption!.copyWith(
              fontSize: 15,
              color: labelColor ?? Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Function? onPressed;
  final Color? backgroundColor;
  final Color? accentColor;
  bool hideBorder;

  SmallButton({
    Key? key,
    required this.label,
    this.labelColor,
    required this.onPressed,
    this.backgroundColor,
    this.accentColor,
    this.hideBorder = false,
    // this.horizontalMargin,
    // this.verticalMargin,
  }) : super(key: key);

  MaterialStateProperty<T> changeButtonStyle<T>(style) =>
      MaterialStateProperty.all<T>(style);

  @override
  Widget build(BuildContext context) {
    final fs = fullScreen(context);
    final h = sHeight(context);
    return
        // Container(
        //   height: btnHeight == null ? 52 : btnHeight,
        //   width: btnWidth == null ? double.infinity : btnWidth,
        // child:
        ElevatedButton(
      style: ButtonStyle(
        minimumSize: changeButtonStyle<Size>(Size(
          fs('width'),
          h(46.0),
        )),
        animationDuration: const Duration(
            microseconds: IntConstants.buttonSplashAnimationDuration),
        backgroundColor:
            changeButtonStyle<Color>(backgroundColor ?? AppColor.primaryColor),
        overlayColor: changeButtonStyle<Color>(
          accentColor ?? AppColor.buttonOverlay,
        ),
        shape: changeButtonStyle<OutlinedBorder>(
          hideBorder
              ? const RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))
              : RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0, color: backgroundColor ?? Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
        ),
        elevation: changeButtonStyle<double>(0.0),
      ),
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: labelColor ?? AppColor.primaryColor,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class ExtraSmallButton extends StatelessWidget {
  final String label;
  final Color? labelColor;
  final Function? onPressed;
  final Color? backgroundColor;
  final Color? accentColor;
  bool hideBorder;

  ExtraSmallButton({
    Key? key,
    required this.label,
    this.labelColor,
    required this.onPressed,
    this.backgroundColor,
    this.accentColor,
    this.hideBorder = false,
    // this.horizontalMargin,
    // this.verticalMargin,
  }) : super(key: key);

  MaterialStateProperty<T> changeButtonStyle<T>(style) =>
      MaterialStateProperty.all<T>(style);

  @override
  Widget build(BuildContext context) {
    final fs = fullScreen(context);
    final h = sHeight(context);
    return
        // Container(
        //   height: btnHeight == null ? 52 : btnHeight,
        //   width: btnWidth == null ? double.infinity : btnWidth,
        // child:
        ElevatedButton(
      style: ButtonStyle(
        minimumSize: changeButtonStyle<Size>(Size(
          fs('width'),
          h(45.0),
        )),
        animationDuration: const Duration(
            microseconds: IntConstants.buttonSplashAnimationDuration),
        backgroundColor:
            changeButtonStyle<Color>(backgroundColor ?? AppColor.primaryColor),
        overlayColor: changeButtonStyle<Color>(
          accentColor ?? AppColor.buttonOverlay,
        ),
        shape: changeButtonStyle<OutlinedBorder>(
          hideBorder
              ? const RoundedRectangleBorder(
                  side: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)))
              : RoundedRectangleBorder(
                  side: BorderSide(
                      width: 1.0, color: backgroundColor ?? Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
        ),
        elevation: changeButtonStyle<double>(0.0),
      ),
      onPressed: onPressed == null ? null : () => onPressed!(),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          color: labelColor ?? AppColor.primaryColor,
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
