import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/style/app_colors.dart';

class ButtonWithBorder extends StatelessWidget {
  const ButtonWithBorder({
    required this.text,
    required this.onPressed,
    this.backgroundColor = Colors.white,
    this.textColor = AppColors.grayColor,
    this.borderColor = AppColors.secondGrayColor,
    this.textFontWeight=FontWeight.w500,
    super.key,
  });
 final String text;
 final Color backgroundColor;
 final Color textColor;
  final Color borderColor;
  final FontWeight textFontWeight;
 final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor,width: 1)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(
                  text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: textFontWeight,
                    fontSize: 14.sp,
                    fontFamily: 'DINNextLTArabic_Light',
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}