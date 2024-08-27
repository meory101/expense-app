import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/wdgets/app_text.dart';


class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.primaryColor,
    this.textColor = Colors.white,
    this.side,
    this.width=double.infinity,
    this.fontSize=16,
    super.key,
  });
 final String text;
 final double? width;
 final Color backgroundColor;
 final Color textColor;
 final double fontSize;
 final void Function() onPressed;
 final BorderSide? side;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width!, 60.h),
        maximumSize: Size(width!, 60.h),
        side: side,
        shape: RoundedRectangleBorder(

          borderRadius: BorderRadius.circular(15.r),

        ),
        backgroundColor: backgroundColor,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
      onPressed: onPressed,
      child:  AppText(
        fontSize: fontSize,
        text: text,
        color: textColor,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}