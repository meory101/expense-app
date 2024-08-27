import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

class SectionTitle extends StatelessWidget {
  const SectionTitle({
    required this.icon,
    required this.title,
    required this.onMoreTab,
    super.key,
  });
  final String title;
  final String icon;
  final void Function() onMoreTab;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/$icon.svg',height: 18.h,width: 18.w,),
        SizedBox(width: 5.w,),
        AppText(text: title,fontSize: 16,fontWeight: FontWeight.bold,),
        const Spacer(),
        InkWell(
            onTap: onMoreTab,
            child: AppText(text: context.localizations.show_more,fontWeight: FontWeight.w500,fontSize: 12,color: const Color(0XFF9E9E9E),))
      ],);
  }
}