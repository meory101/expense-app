import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/screens/auth_screens/create_new_account_screens/create_new_account_screen.dart';
import 'package:tasty_booking/screens/auth_screens/login_screens/login_screen.dart';
import 'package:tasty_booking/screens/home_screens/categories_screen.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/notification_helper.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/outside_button_with_icons.dart';


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
                    text: 'مرحبا ${SharedPrefController().getValueFor(key: PrefKeys.name.name)} 👋',
                    fontFamily: 'DINNextLTArabic_bold',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen(),));
                    },
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16.r)
                      ),
                      child: Icon(Icons.menu_open_outlined,color: Colors.white,size: 30.sp,),
                    ),
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
        SizedBox(height: 60.h,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(16.r)
          ),
          child: Row(
            children: [
              AppText(text: ' الإسم : ',),
              AppText(text: SharedPrefController().getValueFor(key: PrefKeys.name.name),),
            ],
          ),
        ),
        SizedBox(height: 20.h,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(16.r)
          ),
          child: Row(
            children: [
              AppText(text: ' البريد الإلكتروني : ',),
              AppText(text: SharedPrefController().getValueFor(key: PrefKeys.email.name),),
            ],
          ),
        ),
        SizedBox(height: 20.h,),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(16.r)
          ),
          child: Row(
            children: [
              AppText(text: ' رقم الهاتف : ',),
              AppText(text: SharedPrefController().getValueFor(key: PrefKeys.phone.name),),
            ],
          ),
        ),
        SizedBox(height: 20.h,),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.primaryColor),
              borderRadius: BorderRadius.circular(16.r)
          ),
          child: Row(
            children: [
              SvgPicture.asset('assets/images/notification.svg',height:25.h,width: 25.w, ),
              SizedBox(width: 20.w,),
              AppText(text: 'الاشعارات',fontWeight: FontWeight.bold,fontSize: 14,),
              Spacer(),
              SizedBox(
                height: 35.h,

                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(

                    value: notificationOn,
                    activeColor: Color(0xffE8F5E9),
                    inactiveTrackColor: Color(0xff9E9B9B),
                    inactiveThumbColor:Color(0xffE8F5E9),
                    trackOutlineColor:
                    const WidgetStatePropertyAll(Colors.transparent),
                    activeTrackColor: Color(0xff4CAF50),
                    onChanged: (value) {
                      setState(() {
                        notificationOn = !notificationOn;
                      });
                    },
                  ),
                ),
              ),

            ],
          ),
        ),
        SizedBox(height: 50.h,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: OutSideButtonWithIcon(
            title: 'تسجيل الخروج',
            icon: Icon(Icons.logout,color: Colors.red,),
            outSideColor: Colors.red,
            onPressed: () async{
            await FirebaseAuth.instance.signOut();
            await SharedPrefController().clear();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LogInScreen(),), (route) => false);
          },),
        ),
        SizedBox(height: 20.h,),
      ],
    );
  }
}
