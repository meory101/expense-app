// ignore_for_file: use_key_in_widget_constructors, file_names, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/utils/helpers.dart';

import '../../style/app_colors.dart';


class CommonQuestionsScreen extends StatefulWidget {
  @override
  State<CommonQuestionsScreen> createState() => _CommonQuestionsScreenState();
}

class _CommonQuestionsScreenState extends State<CommonQuestionsScreen> {
int? currentIndex;
bool isCurrentIndex=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Stack(
          children: [
            Column(
              children: <Widget>[
                SafeArea(
                  child: SizedBox(
                    height: 0.h,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.r),
                              border: Border.all(color: AppColors.grayBorderColor,width: 1)

                          ),
                          height: 60.h,
                          width: 60.w,
                          child: SvgPicture.asset("assets/images/x.svg"),
                          padding: EdgeInsets.symmetric(horizontal:18.w,vertical:18.h),

                        ),
                      ),
                      SizedBox(width: 18.w),
                      Expanded(
                        child: Text('مركز المساعدة',
                          style: TextStyle(
                            fontFamily: "DINNextLTArabic_Light",
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                          ),textAlign: TextAlign.center,),
                      ),

                      SizedBox(width: 78.w),
                    ],
                  ),
                ),



                SizedBox(height: 34.h),



              ],
            ),
            Positioned.fill(
              top: 190.h,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r)),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 32.h),
                    Container(
                      height: 60.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: AppColors.grayBorderColor,width: 1)


                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 16.w),
                          SvgPicture.asset("assets/images/Search.svg"),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: context.localizations.search,
                                  hintStyle: TextStyle(
                                      fontFamily: "DINNextLTArabic_bold",
                                      color: Color(0xFFCFCFCF),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600

                                  )
                              ),
                            ),
                          )

                        ],
                      ),
                    ),
                    SizedBox(height: 22.h),
                    Expanded(
                      child: Container(
                        child: ListView.separated(
                          padding: EdgeInsets.only(top: 0.h),
                            separatorBuilder: (context, index) {
                          return SizedBox(height: 17.h);

                        }, itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              currentIndex=index;
                              isCurrentIndex=!isCurrentIndex;
                              setState(() {

                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(color: const Color(0xFFF4F4F4),width: 1)
                              ),
                              child:
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(child: Text(context.localizations.onboarding_text,
                                      style: TextStyle(
                                          fontFamily: "DINNextLTArabic_bold",
                                          color: AppColors.blackColor,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w700,
                                          decoration: TextDecoration.none,
                                          fontStyle: FontStyle.normal
                                      )
                                      )),
                                      SizedBox(width: 12.w),
                                      currentIndex==index&&isCurrentIndex?
                                      SvgPicture.asset("assets/images/ArrowDown2.svg"):
                                      SvgPicture.asset("assets/images/ArrowRight2.svg")

                                    ],
                                  ),
                                  currentIndex==index&&isCurrentIndex?Column(
                                    children: [
                                      SizedBox(height: 16.h),
                                      Container(
                                        height: 1.h,
                                        color: Color(0xFFEEEEEE),
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(context.localizations.onboarding_description,
                                        style: TextStyle(
                                            fontFamily: "DINNextLTArabic_Light",
                                            color: AppColors.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400,
                                            decoration: TextDecoration.none,
                                            fontStyle: FontStyle.normal
                                        ),
                                      )
                                    ],
                                  ):SizedBox(height: 0.h,)

                                ],
                              ),
                            ),
                          );

                        }, itemCount: 5),
                      ),
                    ),
                    SizedBox(height: 16.h),
                  ],
                )
              ),
            )
          ],
        ),

    );
  }
}
