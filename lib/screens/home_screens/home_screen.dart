import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasty_booking/screens/home_screens/line_chart_sample2.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 50.h),
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          child: Row(
            children: [
              AppText(
                text: '${context.localizations.hi} محمد خالد 👋 ',
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
        ),
        SizedBox(height: 16.h,),
        LineChartSample2()
      ],
    );
  }
}




