import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

class PaymentTypeWidget extends StatelessWidget {
  const PaymentTypeWidget({
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    super.key,
  });
 final String title;
 final String subTitle;
 final String icon;
 final bool isSelected;
 final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: const MaterialStatePropertyAll(Colors.transparent),
      child: Container(
        height: 75.h,
        width: double.infinity,
        padding: EdgeInsetsDirectional.only(start: 17.w,end: 20.w,top: 10.h,bottom: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: isSelected? const Color(0XFF1BAC4B): const Color(0XFFEAEAEA),width: 1.w),
          color: isSelected? const Color(0XFF1BAC4B).withOpacity(0.1):Colors.white
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 59.w,
              child: SvgPicture.asset('assets/images/$icon.svg'),
            ),
            SizedBox(width: 21.w,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 AppText(
                  text: title,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DINNextLTArabic_bold',
                  textAlign: TextAlign.start,
                   color: isSelected? const Color(0XFF1BAC4B):AppColors.blackColor,
                ),
                SizedBox(height: 7.5.h,),
                 AppText(
                  text: subTitle,
                  fontSize: 12,
                  textAlign: TextAlign.start,
                  color: const Color(0XFFBDBDBD),
                ),
              ],
            ),
            const Spacer(),
            isSelected?SvgPicture.asset('assets/images/paymentSelectedIcon.svg',height: 20.h,width:20.w,):Container(
              height: 20.h,
              width: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0XFFE2E8F0),),
              ),
            )
          ],
        ),
      ),
    );
  }
}