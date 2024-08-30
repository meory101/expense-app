import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/wdgets/app_back_button.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

import '../../style/app_colors.dart';

class DetailsItemScreen extends StatefulWidget {
  const DetailsItemScreen({super.key});

  @override
  State<DetailsItemScreen> createState() => _DetailsItemScreenState();
}

class _DetailsItemScreenState extends State<DetailsItemScreen> {
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
                    const Spacer(),
                    const AppText(
                      text: 'التفاصيل لكل صنف',
                      fontFamily: 'DINNextLTArabic_bold',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const Spacer(flex: 2,),
                    const SizedBox(),
                  ],
                ),
                SizedBox(height: 16.h,),
              ],
            ),
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      ]
                  ),
                  child: Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: 'اسم الصنف : ',fontSize: 18,color: Colors.black,),
                          AppText(text: 'ترفيه',fontSize: 18,color: AppColors.primaryColor,fontWeight: FontWeight.w600,),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: 'الاستهلاك المصروفي : ',fontSize: 18,color: Colors.black,),
                          AppText(text: '450',fontSize: 18,color: AppColors.primaryColor,fontWeight: FontWeight.w600,),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(text: 'الحد الاعلى : ',fontSize: 18,color: Colors.black,),
                          AppText(text: '500',fontSize: 18,color: AppColors.primaryColor,fontWeight: FontWeight.w600,),
                        ],
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.h,),
                const Divider(thickness: 2,color: AppColors.primaryColor,),
                SizedBox(height: 20.h,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.person_pin,color: AppColors.primaryColor,),
                      SizedBox(width: 8.w,),
                      const AppText(
                        text: 'مقارنة مع المستخدمين في نفس المنطقة',
                        fontFamily: 'DINNextLTArabic_bold',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),
                ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap:  true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                            ]
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const AppText(text: 'أحمد علي',fontSize: 18,color: AppColors.primaryColor,),
                             const Spacer(),
                             AppText(text: '${100*(index+1)}',fontSize: 18,color: AppColors.primaryColor,),
                          ],
                        ),
                      );
                    }, separatorBuilder: (context, index) => SizedBox(height: 16.h,), itemCount: 4),
                SizedBox(height: 20.h,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
