import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/main.dart';
import 'package:tasty_booking/wdgets/app_back_button.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

import '../../style/app_colors.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            child: Column(
              children: [
                SizedBox(height: 40.h,),
                Row(
                  children: [
                    AppBackButton(onTap: () => Navigator.pop(context),iconColor: Colors.white,),
                    Spacer(),
                    const AppText(
                      text: 'التصنيفات',
                      fontFamily: 'DINNextLTArabic_bold',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    Spacer(flex: 2,),
                    SizedBox(),
                  ],
                ),
                SizedBox(height: 16.h,),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
                
                itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                    borderRadius: BorderRadius.circular(16.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AppText(text: ' اسم الصنف ',fontSize: 18,color: AppColors.primaryColor,),
                    const AppText(text: '500',fontSize: 18,color: AppColors.primaryColor,),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                      decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(10.r),
                          color: AppColors.primaryColor
                      ),
                      child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                    )
                  ],
                ),
              );
            }, separatorBuilder: (context, index) => SizedBox(height: 16.h,), itemCount: 5),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {

          },
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.add,color: Colors.white,),
          ),
          SizedBox(height: 40.h,)
        ],
      ),
    );
  }
}
