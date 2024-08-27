import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppBackButton extends StatelessWidget {
  AppBackButton({
    required this.onTap,
    this.iconColor,
    super.key,
  });
 final void Function() onTap;
 final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.r),
              border: Border.all(color: const Color(0XFFE5E7EB),width: 1.w)
          ),
          child: Padding(
            padding:  EdgeInsets.only(right: 40.w),
            child: Icon(Icons.arrow_back_outlined,size: 24.sp,color: iconColor,),
          ),
        ),
      ),
    );
  }
}