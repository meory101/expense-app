import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/style/app_colors.dart';


class AppText extends StatelessWidget {
  const AppText(
      {required this.text,
      this.fontSize = 16,
      this.color = AppColors.mainTitleColor,
      this.fontWeight,
      this.textAlign,
      this.height,
      this.letterSpacing,
      this.fontFamily = 'DINNextLTArabic_Light',
        this.overflow,
      Key? key})
      : super(key: key);
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final String fontFamily;
  final double? height;
  final double? letterSpacing;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
          fontSize: fontSize.sp,
          fontWeight: fontWeight,
          color: color,
          fontFamily: fontFamily,
        height:height,
        overflow: overflow,
        letterSpacing: letterSpacing
      ),
    );
  }
}
