import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/style/app_colors.dart';

class CustomAppLoading extends StatelessWidget {
  const CustomAppLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 418.h,horizontal: 167.5.w),
      decoration:
      BoxDecoration(color: Colors.black.withOpacity(0.3),),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 25.h),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x339B9B9B),
                blurRadius: 75,
                offset: Offset(0, 0),
                spreadRadius: 0,
              )
            ],
          ),
          child: CircularProgressIndicator(backgroundColor: Colors.grey.withOpacity(0.4),color: AppColors.primaryColor,strokeCap: StrokeCap.round,),
        ),
      )
    );
  }
}
