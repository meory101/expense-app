import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/main.dart';
import 'package:tasty_booking/screens/home_screens/categories_screen.dart';
import 'package:tasty_booking/wdgets/app_back_button.dart';
import 'package:tasty_booking/wdgets/app_elevated_button.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';
import 'package:tasty_booking/wdgets/button_with_border.dart';
import 'package:tasty_booking/wdgets/outside_button_with_icons.dart';

import '../../style/app_colors.dart';
import '../../wdgets/app_drop_down.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  late TextEditingController costTextController;
  late TextEditingController newCategoryTextController;
  String?_selectedCategoryId;
  List<String> mainCategory = <String>[
    'ترفيه',
    'فواتير',
    'مستلزمات اساسية',
    'مواصلات',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    costTextController = TextEditingController();
    newCategoryTextController = TextEditingController();
  }

  @override
  void dispose() {
    costTextController.dispose();
    newCategoryTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
          decoration: const BoxDecoration(color: AppColors.primaryColor),
          child: Column(
            children: [
              SizedBox(height: 40.h,),
              AppText(
                text: 'اضافة مصروف جديد',
                fontFamily: 'DINNextLTArabic_bold',
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              SizedBox(height: 16.h,),
            ],
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
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
                AppTextField(
                  controller: costTextController,
                  hintText: 'المصروف (رقم)',
                  keyboardType: TextInputType.number,
                  prefixIcon: Icon(Icons.attach_money_outlined),
                ),
                SizedBox(
                  height: 30.h,
                ),
                AppDropDown<String>(
                  hint: 'اختار تصنيف',
                  onChanged: (String? value) {
                    setState(() {
                      _selectedCategoryId = value;
                      newCategoryTextController.clear();
                    });
                  },
                  color: _selectedCategoryId != null ? AppColors.primaryColor:AppColors.secondGrayColor,
                  value: _selectedCategoryId,
                  items: mainCategory.map(
                    (category) {
                      return DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      );
                    },
                  ).toList(),
                  marginTop: 15.h,
                ),
                SizedBox(
                  height: 30.h,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                    child: AppText(text: 'في حل عدم اختيار تصنيف اساسي يرجى اضافة التصنيف المطلوب',fontSize: 12,textAlign: TextAlign.start,)),
                SizedBox(
                  height: 10.h,
                ),
                AppTextField(
                  controller: newCategoryTextController,
                  hintText: 'تصنيف اخر',
                  keyboardType: TextInputType.text,
                  enabled: _selectedCategoryId==null,
                  prefixIcon: Icon(Icons.menu_open_outlined),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: AppElevatedButton(text: 'اضافة', onPressed: () {
                        
                      },),
                    ),
                    SizedBox(width: 16.w,),
                    Expanded(
                      child: ButtonWithBorder(
                        text: 'حذف البيانات',
                        onPressed: () {
                        setState(() {
                          costTextController.clear();
                          newCategoryTextController.clear();
                          _selectedCategoryId = null;
                        },
                        );
                      },
                        borderColor: Colors.red.withOpacity(0.8),
                        textColor: Colors.red.withOpacity(0.8),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 50.h,
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: OutSideButtonWithIcon(
            title: ' التصنيفات',
            icon: Icon(
            Icons.menu_open_outlined,
            color: AppColors.primaryColor,
            size: 30.sp,
          ),
            onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CategoriesScreen(),
                ));
          },
          ),
        )

      ],
    );
  }
}
