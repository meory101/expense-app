import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/screens/home_screens/categories_screen.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import '../../fb_controller/fb_firestore.dart';
import '../../model/Debts_model.dart';
import '../../wdgets/app_text_field.dart';
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

  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController debtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Column(
                children: [
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    children: [
                      AppText(
                        text:
                            'مرحبا ${SharedPrefController().getValueFor(key: PrefKeys.name.name)} 👋',
                        fontFamily: 'DINNextLTArabic_bold',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoriesScreen(),
                              ));
                        },
                        child: Container(
                          height: 60.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Icon(
                            Icons.menu_open_outlined,
                            color: Colors.white,
                            size: 30.sp,
                          ),
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
                  SizedBox(
                    height: 16.h,
                  ),
                ],
              ),
            ),

            StreamBuilder<QuerySnapshot<Debts>>(
              stream: FbFirestoreController().readDebts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center();
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      AppText(
                        text: 'ديون لم تكتمل',
                        fontFamily: 'DINNextLTArabic_bold',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 20.h),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return double.parse(snapshot.data!.docs[index]
                                        .data()
                                        .Amount_Depts) >
                                    double.parse(snapshot.data!.docs[index]
                                        .data()
                                        .Amount_Paid_Depts)
                                ? InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Dialog(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 16.w,
                                                    vertical: 20.h),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      'تغير قيمة الدين المدفوع',
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'DINNextLTArabic_Light',
                                                          color: AppColors
                                                              .primaryColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16.sp),
                                                    ),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    Form(
                                                      key: formKey,
                                                      child: AppTextField(
                                                        validator: (value) {
                                                          if ((value ?? "")
                                                              .isEmpty) {
                                                            return "الحقل مطلوب";
                                                          }
                                                          return null;
                                                        },
                                                        hintText:
                                                            'الدين المدفوع',
                                                        controller:
                                                            debtController,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 16.h,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            if (!formKey
                                                                .currentState!
                                                                .validate()) {
                                                              return;
                                                            }
                                                            print(
                                                                await FirebaseMessaging
                                                                    .instance
                                                                    .getToken());
                                                            await FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'Debts')
                                                                .doc(snapshot
                                                                    .data!
                                                                    .docs[index]
                                                                    .reference
                                                                    .id)
                                                                .set(
                                                                    {
                                                                  'Amount_Paid_Depts':
                                                                      debtController
                                                                          .text,
                                                                },
                                                                    SetOptions(
                                                                        merge:
                                                                            true)).then(
                                                              (value) {
                                                                if (double.parse(
                                                                        debtController
                                                                            .text) >=
                                                                    (0.8) *
                                                                        double.parse(
                                                                            '${snapshot.data!.docs[index].data().Amount_Depts}')) {
                                                                  print(
                                                                      '0000000000000000000');
                                                                  FlutterLocalNotificationsPlugin().show(
                                                                      1,
                                                                      "مرحباا",
                                                                      "لقد حققت قيمة 80  من الدين",
                                                                      NotificationDetails(
                                                                          android: AndroidNotificationDetails(
                                                                        'foodify',
                                                                        'foodify',
                                                                        channelDescription:
                                                                            'foodify',
                                                                        importance:
                                                                            Importance.high,
                                                                        priority:
                                                                            Priority.low,
                                                                        playSound:
                                                                            true,
                                                                        colorized:
                                                                            true,
                                                                        category:
                                                                            AndroidNotificationCategory.event,
                                                                        channelAction:
                                                                            AndroidNotificationChannelAction.createIfNotExists,
                                                                      )));
                                                                }

                                                                debtController
                                                                    .text = "";
                                                              },
                                                            );

                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            setState(() {});
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        38.w,
                                                                    vertical:
                                                                        10.h),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .r),
                                                                color: AppColors
                                                                    .primaryColor),
                                                            child: const Center(
                                                                child: AppText(
                                                              text: 'تغيير',
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 16.w,
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            debtController
                                                                .text = "";
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        38.w,
                                                                    vertical:
                                                                        10.h),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(10
                                                                            .r),
                                                                color: AppColors
                                                                    .secondGrayColor),
                                                            child: Center(
                                                                child: AppText(
                                                              text: 'الغاء',
                                                              color: AppColors
                                                                  .primaryColor,
                                                            )),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 20.h),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: AppColors.primaryColor,
                                              width: 2.w),
                                          borderRadius:
                                              BorderRadius.circular(16.r)),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              AppText(text: 'اسم المدين : '),
                                              SizedBox(
                                                width: 16.w,
                                              ),
                                              AppText(
                                                text:
                                                    '${snapshot.data!.docs[index].data().Name}',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              AppText(text: 'قيمة الدين  :'),
                                              SizedBox(
                                                width: 18.w,
                                              ),
                                              AppText(
                                                text:
                                                    '${snapshot.data!.docs[index].data().Amount_Depts}',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              AppText(
                                                  text:
                                                      'قيمة الدين المدفوع  :'),
                                              SizedBox(
                                                width: 18.w,
                                              ),
                                              AppText(
                                                text:
                                                    '${snapshot.data!.docs[index].data().Amount_Paid_Depts}',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              const AppText(
                                                  text: 'تاريخ السداد :'),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              AppText(
                                                text:
                                                    '${snapshot.data!.docs[index].data().Date}',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          Row(
                                            children: [
                                              const AppText(
                                                  text: 'الملاخظات :'),
                                              SizedBox(
                                                width: 15.w,
                                              ),
                                              AppText(
                                                text:
                                                    '${snapshot.data!.docs[index].data().Note}',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          }),
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
            ),
            // SizedBox(height: 30.h,),

            StreamBuilder<QuerySnapshot<Debts>>(
              stream: FbFirestoreController().readDebts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center();
                } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return Column(
                    children: [
                      AppText(
                        text: 'ديون مكتملة',
                        fontFamily: 'DINNextLTArabic_bold',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 22.w, vertical: 20.h),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return double.parse(snapshot.data!.docs[index]
                                        .data()
                                        .Amount_Depts) <=
                                    double.parse(snapshot.data!.docs[index]
                                        .data()
                                        .Amount_Paid_Depts)
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 16.w, vertical: 20.h),
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.primaryColor,
                                            width: 2.w),
                                        borderRadius:
                                            BorderRadius.circular(16.r)),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            AppText(text: 'اسم المدين : '),
                                            SizedBox(
                                              width: 16.w,
                                            ),
                                            AppText(
                                              text:
                                                  '${snapshot.data!.docs[index].data().Name}',
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            AppText(text: 'قيمة الدين  :'),
                                            SizedBox(
                                              width: 18.w,
                                            ),
                                            AppText(
                                              text:
                                                  '${snapshot.data!.docs[index].data().Amount_Depts}',
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            AppText(
                                                text: 'قيمة الدين المدفوع  :'),
                                            SizedBox(
                                              width: 18.w,
                                            ),
                                            AppText(
                                              text:
                                                  '${snapshot.data!.docs[index].data().Amount_Paid_Depts}',
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            const AppText(
                                                text: 'تاريخ السداد :'),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppText(
                                              text:
                                                  '${snapshot.data!.docs[index].data().Date}',
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Row(
                                          children: [
                                            const AppText(text: 'الملاخظات :'),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            AppText(
                                              text:
                                                  '${snapshot.data!.docs[index].data().Note}',
                                              fontWeight: FontWeight.bold,
                                              color: AppColors.primaryColor,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox();
                          }),
                    ],
                  );
                } else {
                  return const Text('');
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddDebtsScreen(),
                  ));
            },
            backgroundColor: AppColors.primaryColor,
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 10.h,
          )
        ],
      ),
    );
  }
}
