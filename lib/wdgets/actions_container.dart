import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ActionsContainer extends StatelessWidget {
  const ActionsContainer({
    required this.icon,
    required this.onTap,
    this.padding = 18,
    super.key,
  });
 final String icon;
 final void Function() onTap;
 final double padding;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Blur(
            blur: 2.5,
            blurColor: const Color(0XFF9F9F9F).withOpacity(0.25),
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              height: 60.h,
              width: 60.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          ),
          Container(
            height: 60.h,
            width: 60.w,
            padding: EdgeInsets.symmetric(horizontal: padding.w,vertical: padding.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: SvgPicture.asset('assets/images/$icon.svg',height: double.infinity.h,width: double.infinity.w,),
          ),
        ],
      ),
    );
  }
}