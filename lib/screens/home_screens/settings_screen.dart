import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

import '../profile_screen/common_questions_screen.dart';
import '../profile_screen/edit_profile_screen.dart';
import '../profile_screen/love_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationOn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
              children: [

                Column(
                  children: [
                    SvgPicture.asset('assets/images/Profile.svg',height:200.h,width: double.infinity, ),
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: 110.h,),
                      SvgPicture.asset('assets/images/Avatar.svg',height:120.h,width: 120.w, ),


                    ],
                  ),
                )



              ],
            ),
          SizedBox(height: 10.h,),
          Padding(
            padding:  EdgeInsets.all(26.w),
            child: Column(
              children: [
                InkWell(
                  onTap: ()
                  {
                     Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => EditProfileScreen()));
                  },
                  child: Column(
                    children: [

                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/setting-4.svg',height:25.h,width: 25.w, ),
                            SizedBox(width: 20.w,),
                            AppText(text: 'تعديل بيانات الحساب',fontWeight: FontWeight.bold,fontSize: 14,),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 13,),

                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grayBorderColor,
                      ),

                    ],
                  ),
                ),
                InkWell(
                  onTap: ()
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => LoveScreen()));
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),

                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/Love.svg',height:25.h,width: 25.w, ),
                            SizedBox(width: 20.w,),
                            AppText(text: 'المفضلة',fontWeight: FontWeight.bold,fontSize: 14,),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 13,),

                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grayBorderColor,
                      ),


                    ],
                  ),
                ),
                Column(
                    children: [
                      SizedBox(height: 20.h,),

                      Container(
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
                      SizedBox(height: 20.h,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grayBorderColor,
                      ),


                    ],
                  ),





                InkWell(
                  onTap: ()
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditProfileScreen()));
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),

                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/unlock.svg',height:25.h,width: 25.w, ),
                            SizedBox(width: 20.w,),
                            AppText(text: 'تغيير كلمة المرور',fontWeight: FontWeight.bold,fontSize: 14,),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 13,),

                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grayBorderColor,
                      ),


                    ],
                  ),
                ),




                InkWell(
                  onTap: ()
                  {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CommonQuestionsScreen()));
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 20.h,),


                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/task-square.svg',height:25.h,width: 25.w, ),
                            SizedBox(width: 20.w,),
                            AppText(text: 'مركز المساعدة',fontWeight: FontWeight.bold,fontSize: 14,),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 13,),

                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grayBorderColor,
                      ),


                    ],
                  ),
                ),




                InkWell(
                  onTap: ()
                  {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) => EditProfileScreen()));
                  },
                  child: Column(
                    children: [

                      SizedBox(height: 20.h,),

                      Container(
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/images/logout.svg',height:25.h,width: 25.w, ),
                            SizedBox(width: 20.w,),
                            AppText(text: 'تسجيل الخروج',fontWeight: FontWeight.bold,fontSize: 14,color: Colors.red,),
                            Spacer(),
                            Icon(Icons.arrow_forward_ios_outlined,size: 13,),

                          ],
                        ),
                      ),
                      SizedBox(height: 20.h,),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColors.grayBorderColor,
                      ),


                    ],
                  ),
                ),

              ],
            ),
          )


        ],
      ),
    );
  }
}
