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
  late TextEditingController _cobonController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cobonController = TextEditingController();
  }

  @override
  void dispose() {
    _cobonController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 60.h),
        itemBuilder: (context, index) {
      return  SizedBox();
    }, separatorBuilder: (context, index) => SizedBox(height: 19.h,), itemCount: 0);
  }
}
