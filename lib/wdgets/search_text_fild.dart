import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';

class SearchTextFiled extends StatelessWidget {
  const SearchTextFiled({
    required this.controller,
    this.suffixIcon,
    required this.hint,
    super.key,
  });
  final TextEditingController controller;
  final Widget? suffixIcon;
  final String hint;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      showCursor: true,
      cursorColor: AppColors.primaryColor,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: Padding(
          padding:  EdgeInsets.symmetric(vertical: 18.h),
          child: SvgPicture.asset('assets/images/searchIcon.svg'),
        ),
        hintText: hint,
        counterText: '',
        errorMaxLines: 1,
        errorStyle:  TextStyle(fontSize: 0.0.sp),
        fillColor: Color(0XFFF9F9F9),
        filled: true,
        hintStyle: TextStyle(
          fontSize: 16.sp, color:  AppColors.grayColor,
          fontWeight: FontWeight.w400,
          fontFamily: 'DINNextLTArabic_Light',
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(width: 2.w, color:  AppColors.primaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(width: 0.50.w, color:  AppColors.secondGrayColor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(width: 0.50.w, color:  AppColors.secondGrayColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(width: 1.w, color:  Colors.red),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(width: 1.w, color:  Colors.red),
        ),

      ),


    );
  }
}