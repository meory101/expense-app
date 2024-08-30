import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/style/app_colors.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    Key? key,
    required this.hint,
    required this.items,
    this.marginTop = 25,
    required this.onChanged,
    this.value,
    this.color = AppColors.secondGrayColor,
  }) : super(key: key);

  final double marginTop;
  final String hint;
  final void Function(T?) onChanged;
  final List<DropdownMenuItem<T>>? items;
  final T? value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      margin: EdgeInsetsDirectional.only(top: marginTop.h),
      alignment: Alignment.center,
      padding: EdgeInsetsDirectional.only(start: 25.w, end: 15.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 0.5,
          color:color,
        ),
      ),
      child: DropdownButton<T>(
        isExpanded: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(6),
        underline: const SizedBox(),
        hint: Text(
          hint,
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.primaryColor,
              fontFamily: 'DINNextLTArabic_Light',
          ),
        ),
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColors.primaryColor,
          fontFamily: 'DINNextLTArabic_Light',
        ),
        value: value,
        onChanged: onChanged,
        items: items,
      ),
    );
  }
}