import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_chart/commons/data_model/data_model.dart';
import 'package:d_chart/commons/enums.dart';
import 'package:d_chart/numeric/combo.dart';
import 'package:d_chart/numeric/line.dart';
import 'package:d_chart/ordinal/bar.dart';
import 'package:d_chart/time/combo.dart';
import 'package:d_chart/time/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/fb_controller/fb_firestore.dart';
import 'package:tasty_booking/model/expense_model.dart';
import 'package:tasty_booking/screens/home_screens/compare_with_users_screen.dart';
import 'package:tasty_booking/screens/home_screens/profile_screen.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_back_button.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/custom_app_loading.dart';

import '../../style/app_colors.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'categories_screen.dart';

class DetailsItemScreen extends StatefulWidget {
  const DetailsItemScreen(
      {super.key,
      required this.type,
      required this.cost,
      required this.ceiling,
      required this.collection,
      required this.docId});

  final String type;
  final String cost;
  final String ceiling;
  final String collection;
  final String? docId;

  @override
  State<DetailsItemScreen> createState() => _DetailsItemScreenState();
}

String? userId;

String? userName;

double? totalExpense;

class _DetailsItemScreenState extends State<DetailsItemScreen> {
  bool notificationOn = false;

  // final numericGroupList = [
  //   NumericGroup(
  //     id: '1',
  //     data: numericDataList,
  //   ),
  // ];
  @override
  void initState() {
    initSwitch();
    getExpenses();
    super.initState();
  }

  initSwitch() async {
    // notificationOn =
    //     await SharedPrefController().getCategorySwitch(widget.type);
    setState(() {});
    print(notificationOn);
  }

  var data;

  getExpenses() async {
    data = FirebaseFirestore.instance
        .collection('ExpenseAmount')
        .where('userId',
            isEqualTo:
                SharedPrefController().getValueFor(key: PrefKeys.userId.name))
        .snapshots();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
            decoration: const BoxDecoration(color: AppColors.primaryColor),
            child: Column(
              children: [
                SizedBox(
                  height: 40.h,
                ),
                Row(
                  children: [
                    AppBackButton(
                      onTap: () => Navigator.pop(context),
                      iconColor: Colors.white,
                    ),
                    const Spacer(),
                    const AppText(
                      text: 'التفاصيل لكل صنف',
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
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.primaryColor, width: 0.5.w),
                      borderRadius: BorderRadius.circular(16.r),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 3))
                      ]),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'اسم الصنف : ',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          AppText(
                            text: widget.type,
                            fontSize: 18,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'الاستهلاك المصروفي : ',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          AppText(
                            text: widget.cost,
                            fontSize: 18,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: 'الحد الاعلى : ',
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          AppText(
                            text: widget.ceiling,
                            fontSize: 18,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Divider(
                  thickness: 2,
                  color: AppColors.primaryColor,
                ),
                SizedBox(
                  height: 20.h,
                ),
                notificationOn == true
                    ? Column(
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          StreamBuilder<QuerySnapshot<ExpenseModel>>(
                            stream: FbFirestoreController().readSeamUserArea(
                                widget.collection,
                                SharedPrefController()
                                    .getValueFor(key: PrefKeys.userArea.name)),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const SizedBox();
                              } else if (snapshot.hasData &&
                                  snapshot.data!.docs.isNotEmpty) {
                                // خريطة لتجميع البيانات حسب userId
                                Map<String, Map<String, dynamic>> userExpenses =
                                    {};

                                // تجميع البيانات حسب userId
                                for (var doc in snapshot.data!.docs) {
                                  ExpenseModel expense = doc.data();
                                  String userId = expense.userId;
                                  String userName = expense.userName;
                                  double expenseAmount =
                                      double.parse(expense.expenseAmount);

                                  if (userExpenses.containsKey(userId)) {
                                    userExpenses[userId]!['totalExpense'] +=
                                        expenseAmount; // جمع القيم
                                  } else {
                                    userExpenses[userId] = {
                                      'userName': userName,
                                      'totalExpense': expenseAmount,
                                    }; // إضافة مستخدم جديد
                                  }
                                }
                                List<NumericData> numericDataList =
                                    <NumericData>[
                                  NumericData(domain: 0, measure: 0),
                                ];
                                for (int i = 0; i < userExpenses.length; i++) {
                                  userId = userExpenses.keys.elementAt(i);
                                  userName = userExpenses[userId]!['userName'];
                                  totalExpense =
                                      userExpenses[userId]!['totalExpense'];
                                  numericDataList.add(NumericData(
                                      domain: i + 1,
                                      measure: userExpenses[userId]![
                                          'totalExpense']));
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
                                return Padding(
                                  padding: EdgeInsets.all(26.0.w),
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
                          SizedBox(
                            height: 20.h,
                          ),
                        ],
                      )
                    : Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              text: 'التفاصيل',
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                            InkWell(
                              onTap: () {
                                bool switchValue = SharedPrefController()
                                        .getValueFor(
                                            key: PrefKeys
                                                .compareSwitchValue.name) ??
                                    false;
                                if (switchValue == false) {
                                  context.showSnackBar(
                                      message:
                                          'يرجي تفعيل زر المقارنة في الصفحة الشخصية',
                                      error: true);
                                  return;
                                }
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return CompareWithUsersScreen(
                                        collection: widget.collection);
                                  },
                                ));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: AppColors.primaryColor),
                                child: const Center(
                                    child: AppText(
                                  text: 'قارن',
                                  color: Colors.white,
                                )),
                              ),
                            )
                          ],
                        )),
                      ),
                SizedBox(
                  height: 20.h,
                ),
                StreamBuilder(
                  stream: data,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center();
                    } else if (snapshot.hasData) {
                      return Column(
                        children: List.generate(
                          snapshot.data.docs.length,
                          (index) {
                            print(snapshot.data.docs[index].data());
                            return Slidable(
                              startActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                      onPressed: (context) async {
                                        await FirebaseFirestore.instance
                                            .collection('ExpenseAmount')
                                            .doc(snapshot
                                                .data.docs[index].reference.id)
                                            .delete();

                                        // double value = (double.parse(
                                        //         widget.cost.isEmpty
                                        //             ? "0.0"
                                        //             : widget.cost) -
                                        //     double.parse(snapshot
                                        //             .data.docs[index]
                                        //             .data()['expenseAmount']
                                        //             .isEmpty
                                        //         ? " 0.0"
                                        //         : snapshot.data.docs[index]
                                        //             .data()['expenseAmount']));
                                        // await FirebaseFirestore.instance
                                        //     .collection(widget.collection)
                                        //     .doc(widget.docId)
                                        //     .set({
                                        //   'expenseAmount': value.toString()
                                        // }, SetOptions(merge: true)).then(
                                        //   (value) {
                                        //     Navigator.push(
                                        //         context,
                                        //         MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               CategoriesScreen(),
                                        //         ));
                                        //   },
                                        // );
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'حذف',
                                    ),
                                  ]),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 10.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppColors.primaryColor,
                                        width: 0.5.w),
                                    borderRadius: BorderRadius.circular(16.r),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 10,
                                          offset: Offset(0, 3))
                                    ]),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: 'اسم المصروف : ',
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                        AppText(
                                          text: snapshot.data.docs[index]
                                                  .data()['expenseName'] ??
                                              "--",
                                          fontSize: 18,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: 'الاستهلاك المصروفي : ',
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                        AppText(
                                          text: snapshot.data.docs[index]
                                              .data()['expenseAmount'],
                                          fontSize: 18,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        AppText(
                                          text: 'الحد الاعلى : ',
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                        AppText(
                                          text: widget.ceiling,
                                          fontSize: 18,
                                          color: AppColors.primaryColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                            Text(snapshot.data.docs[index]
                                .data()['expenseName']
                                .toString());
                          },
                        ),
                      );
                    }
                    return Text('');
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PerformanceCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = AppColors.primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    var path = Path();

    // Draw the curve similar to the image using cubic Bezier
    path.moveTo(10, size.height * 0.8); // Starting point

    // Draw curve with multiple Bezier segments
    path.cubicTo(size.width * 0.2, size.height * 0.2, size.width * 0.4,
        size.height * 0.9, size.width * 0.6, size.height * 0.5);
    path.cubicTo(size.width * 0.7, size.height * 0.3, size.width * 0.9,
        size.height * 0.6, size.width, size.height * 0.7);

    // Draw the axes
    var axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.5;

    // Y-axis (Performance)
    canvas.drawLine(Offset(0, size.height), Offset(0, 0), axisPaint);

    // X-axis (Time)
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);

    // Draw the path
    canvas.drawPath(path, paint);

    // Draw the text labels for X-axis and Y-axis
    _drawText(canvas, size, '', Offset(-40, size.height * 0.4), true); // Y-axis
    _drawText(canvas, size, '', Offset(size.width * 0.5, size.height + 20),
        false); // X-axis

    // Add the time markers on the X-axis
    _drawText(canvas, size, 'user1', Offset(0, size.height + 10), false);
    _drawText(canvas, size, 'user2',
        Offset(size.width * 0.25, size.height + 10), false);
    _drawText(canvas, size, 'user3', Offset(size.width * 0.5, size.height + 10),
        false);
    _drawText(canvas, size, 'user4',
        Offset(size.width * 0.75, size.height + 10), false);
  }

  // Method to draw text
  void _drawText(
      Canvas canvas, Size size, String text, Offset position, bool rotate) {
    final textStyle = TextStyle(
      color: Colors.black,
      fontSize: 14,
    );
    final textSpan = TextSpan(
      text: text,
      style: textStyle,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);

    canvas.save();
    if (rotate) {
      canvas.translate(position.dx, position.dy);
      canvas.rotate(-3.14 / 2); // Rotate the text for the Y-axis label
      textPainter.paint(canvas, Offset(0, 0));
      canvas.restore();
    } else {
      textPainter.paint(canvas, position);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
