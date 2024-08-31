import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../../fb_controller/fb_firestore.dart';
import '../../model/expense_model.dart';

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
        SizedBox(height: 34.h,),
        // const LineChartSample2()
        selectedTime == 0 ?
        AppText(text: 'مجموع المصاريف اليومية : 500',color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 17,):
        selectedTime == 1 ?
        AppText(text: 'مجموع المصاريف الشهرية : 500',color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 17,):
        AppText(text: 'مجموع المصاريف السنوية : 500',color: AppColors.primaryColor,fontWeight: FontWeight.bold,fontSize: 17,),

        SizedBox(height: 34.h,),


        selectedTime == 0 ?
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTime('Basic Supplies',DateTime.now().toString().substring(0,10)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty ) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double

                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' مستلزمات اساسية ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'مستلزمات اساسية', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Basic Supplies',),),);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),

              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTime('Entertainment',DateTime.now().toString().substring(0,10)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' ترفيه ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'ترفيه', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Entertainment'),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTime('Bills',DateTime.now().toString().substring(0,10)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' فواتير ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'فواتير', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Bills',),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTime('Transportation',DateTime.now().toString().substring(0,10)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' مواصلات ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'مواصلات', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Transportation',),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              // SizedBox(height: 20.h,),
              // Divider(thickness: 1,color: AppColors.primaryColor,),
              // Center(
              //   child: AppText(
              //     text: 'التصنيفات الجديدة',
              //     fontFamily: 'DINNextLTArabic_bold',
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTime('Expense',DateTime.now().toString().substring(0,10)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap:  true,
                        physics: NeverScrollableScrollPhysics(),
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
                                AppText(text: snapshot.data!.docs[index].data().expenseType,fontSize: 16,color: AppColors.primaryColor,),
                                AppText(text: '${snapshot.data!.docs[index].data().expenseAmount}',color: AppColors.primaryColor,),
                                /*InkWell(
                                  onTap :(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: snapshot.data!.docs[index].data().expenseType, cost: snapshot.data!.docs[index].data().expenseAmount.toString(), ceiling: snapshot.data!.docs[index].data().ceiling,collection: 'Expense',),));

                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(10.r),
                                        color: AppColors.primaryColor
                                    ),
                                    child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                                  ),
                                )*/
                              ],
                            ),
                          );
                        }, separatorBuilder: (context, index) => SizedBox(height: 16.h,), itemCount: snapshot.data!.docs.length);
                  } else {
                    return SizedBox();
                  }
                },
              ),

              SizedBox(height: 20.h,),
            ],
          ),
        ):
        selectedTime == 1 ?
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeMonthe('Basic Supplies',DateTime.now().toString().substring(0,7)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty ) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double

                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' مستلزمات اساسية ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'مستلزمات اساسية', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Basic Supplies',),),);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),

              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeMonthe('Entertainment',DateTime.now().toString().substring(0,7)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' ترفيه ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'ترفيه', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Entertainment'),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeMonthe('Bills',DateTime.now().toString().substring(0,7)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' فواتير ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'فواتير', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Bills',),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeMonthe('Transportation',DateTime.now().toString().substring(0,7)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' مواصلات ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'مواصلات', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Transportation',),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              // SizedBox(height: 20.h,),
              // Divider(thickness: 1,color: AppColors.primaryColor,),
              // Center(
              //   child: AppText(
              //     text: 'التصنيفات الجديدة',
              //     fontFamily: 'DINNextLTArabic_bold',
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeMonthe('Expense',DateTime.now().toString().substring(0,7)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap:  true,
                        physics: NeverScrollableScrollPhysics(),
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
                                AppText(text: snapshot.data!.docs[index].data().expenseType,fontSize: 16,color: AppColors.primaryColor,),
                                AppText(text: '${snapshot.data!.docs[index].data().expenseAmount}',color: AppColors.primaryColor,),
                                /*InkWell(
                                  onTap :(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: snapshot.data!.docs[index].data().expenseType, cost: snapshot.data!.docs[index].data().expenseAmount.toString(), ceiling: snapshot.data!.docs[index].data().ceiling,collection: 'Expense',),));

                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(10.r),
                                        color: AppColors.primaryColor
                                    ),
                                    child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                                  ),
                                )*/
                              ],
                            ),
                          );
                        }, separatorBuilder: (context, index) => SizedBox(height: 16.h,), itemCount: snapshot.data!.docs.length);
                  } else {
                    return SizedBox();
                  }
                },
              ),

              SizedBox(height: 20.h,),
            ],
          ),
        ):
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeYeare('Basic Supplies',DateTime.now().toString().substring(0,4)),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty ) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double

                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' مستلزمات اساسية ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'مستلزمات اساسية', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Basic Supplies',),),);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),

              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeYeare('Entertainment',DateTime.now().toString().substring(0,4)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' ترفيه ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'ترفيه', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Entertainment'),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeYeare('Bills',DateTime.now().toString().substring(0,4)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' فواتير ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'فواتير', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Bills',),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeYeare('Transportation',DateTime.now().toString().substring(0,4)),

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) {
                      try {
                        // تحويل النص إلى double
                        double amount = double.parse(item.data().expenseAmount);
                        return sum + amount;
                      } catch (e) {
                        print('Error parsing expenseAmount: ${item.data().expenseAmount}, skipping...');
                        return sum; // تخطي القيم غير الصالحة
                      }
                    });
/*
                    double totalExpenseAmount = snapshot.data!.docs.fold(0.0, (sum, item) => sum + double.tryParse(item.data().expenseAmount??0.0));
*/
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
                          const AppText(text: ' مواصلات ',color: AppColors.primaryColor,),
                          AppText(text: '${totalExpenseAmount}',color: AppColors.primaryColor,),
                          // InkWell(
                          //   onTap: () {
                          //     // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'مواصلات', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Transportation',),));
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                          //     decoration: BoxDecoration(
                          //         borderRadius:BorderRadius.circular(10.r),
                          //         color: AppColors.primaryColor
                          //     ),
                          //     child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                          //   ),
                          // )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
              // SizedBox(height: 20.h,),
              // Divider(thickness: 1,color: AppColors.primaryColor,),
              // Center(
              //   child: AppText(
              //     text: 'التصنيفات الجديدة',
              //     fontFamily: 'DINNextLTArabic_bold',
              //     fontSize: 22,
              //     fontWeight: FontWeight.bold,
              //     color: AppColors.primaryColor,
              //   ),
              // ),
              SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readSameTimeYeare('Expense',DateTime.now().toString().substring(0,4)),


                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      // padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      // margin: EdgeInsets.symmetric(horizontal: 20.w),
                      // decoration: BoxDecoration(
                      //     border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                      //     borderRadius: BorderRadius.circular(16.r),
                      //     color: Colors.white,
                      //     boxShadow: const [
                      //       BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                      //     ]
                      // ),
                    );
                  } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    return ListView.separated(
                        padding: EdgeInsets.zero,
                        shrinkWrap:  true,
                        physics: NeverScrollableScrollPhysics(),
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
                                AppText(text: snapshot.data!.docs[index].data().expenseType,fontSize: 16,color: AppColors.primaryColor,),
                                AppText(text: '${snapshot.data!.docs[index].data().expenseAmount}',color: AppColors.primaryColor,),
                                /*InkWell(
                                  onTap :(){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: snapshot.data!.docs[index].data().expenseType, cost: snapshot.data!.docs[index].data().expenseAmount.toString(), ceiling: snapshot.data!.docs[index].data().ceiling,collection: 'Expense',),));

                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                                    decoration: BoxDecoration(
                                        borderRadius:BorderRadius.circular(10.r),
                                        color: AppColors.primaryColor
                                    ),
                                    child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                                  ),
                                )*/
                              ],
                            ),
                          );
                        }, separatorBuilder: (context, index) => SizedBox(height: 16.h,), itemCount: snapshot.data!.docs.length);
                  } else {
                    return SizedBox();
                  }
                },
              ),

              SizedBox(height: 20.h,),
            ],
          ),
        ),

      ],
    );
  }
}




