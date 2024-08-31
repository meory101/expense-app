import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/screens/home_screens/categories_screen.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';

import '../../fb_controller/fb_firestore.dart';
import '../../model/Debts_model.dart';
import 'ADD_debts_screen.dart';

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
                      text: 'مرحبا ${SharedPrefController().getValueFor(key: PrefKeys.name.name)} 👋',
                      fontFamily: 'DINNextLTArabic_bold',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen(),));
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
          StreamBuilder<QuerySnapshot<Debts>>(
            stream: FbFirestoreController().readDebts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 20.h),
                      itemCount: snapshot.data!.docs.length,
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
                                   AppText(text: 'اسم المدين : '),
                                  SizedBox(width: 16.w,),
                                   AppText(text: '${snapshot.data!.docs[index].data().Name}',fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                   AppText(text: 'قيمة الدين  :'),
                                  SizedBox(width: 18.w,),
                                   AppText(text: '${snapshot.data!.docs[index].data().Amount_Depts}',fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                                ],
                              ),
                              SizedBox(height: 10.h,),

                              Row(
                                children: [
                                  AppText(text: 'قيمة الدين المدفوع  :'),
                                  SizedBox(width: 18.w,),
                                  AppText(text: '${snapshot.data!.docs[index].data().Amount_Paid_Depts}',fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  const AppText(text: 'تاريخ السداد :'),
                                  SizedBox(width: 15.w,),
                                   AppText(text: '${snapshot.data!.docs[index].data().Date}',fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  const AppText(text: 'الملاخظات :'),
                                  SizedBox(width: 15.w,),
                                  AppText(text: '${snapshot.data!.docs[index].data().Note}',fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return const SizedBox();
              }
            },
          ),


          SizedBox(height: 30.h,)
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AddDebtsScreen(),));

            },
            backgroundColor: AppColors.primaryColor,
            child: Icon(Icons.add,color: Colors.white,),
          ),
          SizedBox(height: 10.h,)
        ],
      ),
    );

  }
}
