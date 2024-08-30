import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasty_booking/screens/home_screens/categories_screen.dart';
import 'package:tasty_booking/screens/home_screens/line_chart_sample2.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';
import 'package:tasty_booking/wdgets/search_text_fild.dart';
import 'package:tasty_booking/wdgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchEditingController;
  int selectedTime = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
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
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesScreen(),));
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

              const AppText(
                text: 'الرئيسية',
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
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.primaryColor),
            borderRadius: BorderRadius.circular(16.r)
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: InkWell(
                  radius: 16.r,
                  onTap: () {
                    setState(() {
                      selectedTime=0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                    decoration: BoxDecoration(
                      color: selectedTime==0?AppColors.primaryColor:Colors.white,
                        borderRadius: BorderRadius.circular(14.r)
                    ),
                    child: Center(child: AppText(text: 'يومي',color: selectedTime==0?Colors.white:AppColors.primaryColor,)),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  radius: 16.r,
                  onTap: () {
                    setState(() {
                      selectedTime=1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                    decoration: BoxDecoration(
                      color: selectedTime==1?AppColors.primaryColor:Colors.white,
                        borderRadius: BorderRadius.circular(14.r)
                    ),
                    child: Center(child: AppText(text: 'شهري',color: selectedTime==1?Colors.white:AppColors.primaryColor,)),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  radius: 16.r,
                  onTap: () {
                    setState(() {
                      selectedTime=2;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 20.h),
                    decoration: BoxDecoration(
                      color: selectedTime==2?AppColors.primaryColor:Colors.white,
                        borderRadius: BorderRadius.circular(14.r)
                    ),
                    child: Center(child: AppText(text: 'سنوي',color: selectedTime==2?Colors.white:AppColors.primaryColor,)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h,),
        const LineChartSample2()
      ],
    );
  }
}




