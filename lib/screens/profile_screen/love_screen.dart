import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

import '../../wdgets/app_back_button.dart';
import '../../wdgets/app_elevated_button.dart';
import '../../wdgets/app_text_field.dart';

class LoveScreen extends StatefulWidget {
  const LoveScreen({super.key});

  @override
  State<LoveScreen> createState() => _LoveScreenState();
}

class _LoveScreenState extends State<LoveScreen> {
  bool notificationOn = true;
  int? currentIndex;
  bool isCurrentIndex=false;
  late TextEditingController _emailEditingController;
  String? emailIsError;

@override
  void initState() {
    // TODO: implement initState
  _emailEditingController = TextEditingController();

  super.initState();
  }
  @override
  void dispose() {
    _emailEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding:  EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBackButton(onTap: () => Navigator.pop(context),),

                AppText(text: 'المفضلة',fontWeight: FontWeight.bold,),
                Text(''),

              ],
            ),
            SizedBox(height: 20.h,),

            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: Color(0XFFBDBDBD),width: 0.5.w)
                    ),
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 125.h,
                              width: double.infinity,
                              child: Image.asset('assets/images/firoozres.png',fit: BoxFit.cover,),
                            ),
                            SizedBox(height: 10.h,),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(text: 'مطعم فيروز مطعم لبناني',fontSize: 18,fontWeight: FontWeight.bold,),
                                  SizedBox(height: 18.h,),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset('assets/images/openNow.svg',height: 20.h,width: 20.w,),
                                              SizedBox(width: 8.w,),
                                              AppText(text: context.localizations.open_now,fontSize: 10,color: AppColors.primaryColor,),
                                              AppText(text: ':',fontSize: 10,color: Color(0XFFBDBDBD),),
                                              AppText(text: '2:00',fontSize: 10,color: AppColors.primaryColor,),
                                              AppText(text: '${context.localizations.evening} - ',fontSize: 10,color: Color(0XFFBDBDBD),),
                                              AppText(text: '02:00',fontSize: 10,color: AppColors.primaryColor,),
                                              AppText(text: context.localizations.morning,fontSize: 10,color: Color(0XFFBDBDBD),),
                                            ],
                                          ),
                                          SizedBox(height: 10.h,),
                                          Row(
                                            children: [
                                              SvgPicture.asset('assets/images/location3.svg',height: 20.h,width: 20.w,),
                                              SizedBox(width: 8.w,),
                                              AppText(text: 'مدينة دبي منطقة الحي الرابع..',fontSize: 10,color: AppColors.primaryColor,),

                                            ],
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 28.5.w,vertical: 13.h),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16.r),
                                            color: AppColors.primaryColor
                                        ),
                                        child: AppText(text: context.localizations.book_table,color: Colors.white,fontSize: 14,fontWeight: FontWeight.w500,),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 21.h,),
                                ],
                              ),
                            )
                          ],),
                        PositionedDirectional(
                            top:18.h,
                            end:18.w,
                            child: SvgPicture.asset('assets/images/loveOutLine.svg',height: 24.h,width: 24.w,))
                      ],
                    ),
                  );
                }, separatorBuilder: (context, index) => SizedBox(height: 16.h,), itemCount: 2)







          ],
        ),
      ),

    );
  }
}
