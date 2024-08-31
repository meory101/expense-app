import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/fb_controller/fb_firestore.dart';
import 'package:tasty_booking/main.dart';
import 'package:tasty_booking/model/expense_model.dart';
import 'package:tasty_booking/screens/home_screens/details_item_screen.dart';
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
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readBasicSupplies('Basic Supplies'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                          ]
                      ),
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
                          const AppText(text: ' مستلزمات اساسية ',color: AppColors.primaryColor,),
                           AppText(text: '${snapshot.data!.docs[0].data().ceiling}/${totalExpenseAmount}',color: AppColors.primaryColor,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'مستلزمات اساسية', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Basic Supplies',),),);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                              decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10.r),
                                  color: AppColors.primaryColor
                              ),
                              child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                            ),
                          )
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
                stream: FbFirestoreController().readBasicSupplies('Entertainment'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                          ]
                      ),
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
                          AppText(text: '${snapshot.data!.docs[0].data().ceiling}/${totalExpenseAmount}',color: AppColors.primaryColor,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'ترفيه', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Entertainment',),));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                              decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10.r),
                                  color: AppColors.primaryColor
                              ),
                              child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                            ),
                          )
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
                stream: FbFirestoreController().readBasicSupplies('Bills'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                          ]
                      ),
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
                          AppText(text: '${snapshot.data!.docs[0].data().ceiling}/${totalExpenseAmount}',color: AppColors.primaryColor,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'فواتير', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Bills',),));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                              decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10.r),
                                  color: AppColors.primaryColor
                              ),
                              child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                            ),
                          )
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
                stream: FbFirestoreController().readBasicSupplies('Transportation'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                          ]
                      ),
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
                          AppText(text: '${snapshot.data!.docs[0].data().ceiling}/${totalExpenseAmount}',color: AppColors.primaryColor,),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsItemScreen(type: 'مواصلات', cost: totalExpenseAmount.toString(), ceiling: snapshot.data!.docs[0].data().ceiling,collection: 'Transportation',),));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                              decoration: BoxDecoration(
                                  borderRadius:BorderRadius.circular(10.r),
                                  color: AppColors.primaryColor
                              ),
                              child: const Center(child: AppText(text: 'التفاصيل',color: Colors.white,)),
                            ),
                          )
                        ],
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                },
              ),
                SizedBox(height: 20.h,),
                Divider(thickness: 2,color: AppColors.primaryColor,),
                Center(
                  child: AppText(
                    text: 'التصنيفات الجديدة',
                    fontFamily: 'DINNextLTArabic_bold',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryColor,
                  ),
                ),
                SizedBox(height: 20.h,),
              StreamBuilder<QuerySnapshot<ExpenseModel>>(
                stream: FbFirestoreController().readBasicSupplies('Expense'),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 32.h),
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                          borderRadius: BorderRadius.circular(16.r),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                          ]
                      ),
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
                                 AppText(text: '${snapshot.data!.docs[index].data().ceiling}/${snapshot.data!.docs[index].data().expenseAmount}',color: AppColors.primaryColor,),
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
      ),
     
    );
  }
}
