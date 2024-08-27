import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasty_booking/wdgets/app_text.dart';


class OutSideButtonWithIcon extends StatelessWidget {
  const OutSideButtonWithIcon({
    required this.title,
    required this.icon,
    required this.onPressed,
    super.key,
  });
 final String title;
 final String icon;
 final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 60.h),
          maximumSize: Size(double.infinity, 60.h),
          backgroundColor: Colors.transparent,
          elevation: 0,
          side: BorderSide(
            width: 1.w,
            color: const Color(0XFFEEEEEE),
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 24.w,
              height: 24.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(),
              child: SvgPicture.asset('assets/images/$icon.svg',height: 24.h,width: 24.w,),
            ),
            SizedBox(width: 8.w,),
            AppText(text: title,fontSize: 14,)
          ],
        ));
  }
}