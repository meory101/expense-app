import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

import '../profile_screen/common_questions_screen.dart';
import '../profile_screen/edit_profile_screen.dart';
import '../profile_screen/love_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notificationOn = true;
/*  late TextEditingController nameTextController;
  late TextEditingController emailTextController;
  late TextEditingController phoneTextController;*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w,),
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          child: Column(
            children: [
              SizedBox(height: 50.h,),
              Row(
                children: [
                  AppText(
                    text: 'مرحبا محمد خالد 👋',
                    fontFamily: 'DINNextLTArabic_bold',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  Spacer(),
                  Container(
                    height: 60.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(16.r)
                    ),
                    child: Icon(Icons.menu_open_outlined,color: Colors.white,size: 30.sp,),
                  )
                ],
              ),

              AppText(
                text: 'الحساب',
                fontFamily: 'DINNextLTArabic_bold',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 16.h,),
            ],
          ),
        ),
        SizedBox(height: 30.h,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(16.r)
          ),
        )
      ],
    );
  }
}
