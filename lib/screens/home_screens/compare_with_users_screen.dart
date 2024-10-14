import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/numeric/line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/main.dart';

import '../../fb_controller/fb_firestore.dart';
import '../../model/expense_model.dart';
import '../../shared_preferences/shared_prefrences_controller.dart';
import '../../style/app_colors.dart';
import '../../wdgets/app_back_button.dart';
import '../../wdgets/app_text.dart';

class CompareWithUsersScreen extends StatefulWidget {
  final String collection;
  const CompareWithUsersScreen({super.key,required this.collection});

  @override
  State<CompareWithUsersScreen> createState() => _CompareWithUsersScreenState();
}

String? userId;

String? userName;

double? totalExpense;
class _CompareWithUsersScreenState extends State<CompareWithUsersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    AppBackButton(
                      onTap: () => Navigator.pop(context),
                      iconColor: Colors.white,
                    ),
                    const Spacer(),
                    const AppText(
                      text: 'مقانة مغ مستخدمين اخرين',
                      fontFamily: 'DINNextLTArabic_bold',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    const SizedBox(),
                  ],
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          StreamBuilder<QuerySnapshot<ExpenseModel>>(
            stream: FbFirestoreController().readSeamUserArea(widget.collection,SharedPrefController().getValueFor(key: PrefKeys.userArea.name)),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                // خريطة لتجميع البيانات حسب userId
                Map<String, Map<String, dynamic>> userExpenses = {};


                // تجميع البيانات حسب userId
                for (var doc in snapshot.data!.docs) {
                  ExpenseModel expense = doc.data();
                  String userId = expense.userId;
                  String userName = expense.userName;
                  double expenseAmount = double.parse(expense.expenseAmount);


                  if (userExpenses.containsKey(userId)) {

                    userExpenses[userId]!['totalExpense'] += expenseAmount; // جمع القيم
                  } else {
                    userExpenses[userId] = {
                      'userName': userName,
                      'totalExpense': expenseAmount,
                    }; // إضافة مستخدم جديد
                  }
                }
                List<NumericData> numericDataList = <NumericData>[
                  NumericData(domain: 0, measure: 0),
                ];
                for(int i=0; i< userExpenses.length;i++){
                  userId = userExpenses.keys.elementAt(i);
                  userName = userExpenses[userId]!['userName'];
                  totalExpense = userExpenses[userId]!['totalExpense'];
                  numericDataList.add( NumericData(domain: i+1, measure: userExpenses[userId]!['totalExpense']));
                  print(numericDataList);
                }
                /*List<NumericData> numericDataList = [
                                    NumericData(domain: 0, measure: 0),
                                    NumericData(domain: 1, measure: userExpenses[userId]!['totalExpense']),
                                    NumericData(domain: 2, measure: userExpenses[userId]!['totalExpense']),
                                    NumericData(domain: 3, measure: userExpenses[userId]!['totalExpense']),
                                    NumericData(domain: 4, measure: userExpenses[userId]!['totalExpense']),
                                  ];*/

                final numericGroupList = [
                  NumericGroup(
                    id: '1',
                    data: numericDataList,
                  ),

                ];
                return   Padding(
                  padding:  EdgeInsets.all(26.0.w),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: DChartLineN(
                      groupList: numericGroupList,
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
      ),
    );
  }
}
