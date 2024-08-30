import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';

class DebtsScreen extends StatefulWidget {
  const DebtsScreen({super.key});

  @override
  State<DebtsScreen> createState() => _DebtsScreenState();
}

class _DebtsScreenState extends State<DebtsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                    const Spacer(),
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

                const AppText(
                  text: 'الديون',
                  fontFamily: 'DINNextLTArabic_bold',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                SizedBox(height: 16.h,),
              ],
            ),
          ),
          SizedBox(height: 16.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w,),
            child: Row(
              children: [
                const AppText(text: 'المجموع الكلي',fontWeight: FontWeight.bold,fontFamily: 'DINNextLTArabic_bold',
                  fontSize: 22,),
                Spacer(),
                const AppText(text: '2000',fontWeight: FontWeight.bold,color: AppColors.primaryColor,fontFamily: 'DINNextLTArabic_bold',
                  fontSize: 22,),
              ],
            ),
          ),
          SizedBox(height: 10.h,),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 20.h),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColor,width: 2.w
                      ),
                      borderRadius: BorderRadius.circular(16.r)
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const AppText(text: 'اسم المدين :'),
                            SizedBox(width: 16.w,),
                            const AppText(text: 'أحمد محسن',fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            const AppText(text: 'قيمة الدين  :'),
                            SizedBox(width: 18.w,),
                            const AppText(text: '500',fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          children: [
                            const AppText(text: 'تاريخ السداد :'),
                            SizedBox(width: 15.w,),
                            const AppText(text: '15/10/2024',fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                      ],
                    ),
                  );
                }),
          ),
          SizedBox(height: 30.h,)
        ],
      ),
    );
  }
}
