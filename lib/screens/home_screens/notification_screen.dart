import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tasty_booking/fb_controller/fb_firestore.dart';
import 'package:tasty_booking/model/normal_notification_model.dart';
import 'package:tasty_booking/model/schedule_notification_model.dart';
import 'package:tasty_booking/screens/home_screens/categories_screen.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<RemoteMessage> _messages = [];


  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 5)));
  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message in foreground: ${message.notification?.title}');
      setState(() {
        _messages.add(message);
      });
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked when app was in background: ${message.notification?.title}');
      setState(() {
        _messages.add(message);
      });
    });

    _firebaseMessaging.getToken().then((String? token) {
      print("Device Token: $token");
    }).catchError((error) {
      print("Failed to get device token: $error");
    });
  }


  @override
  Widget build(BuildContext context) {
    print( 'ppppp${_messages.length}');
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
                  text: 'الاشعارات',
                  fontFamily: 'DINNextLTArabic_bold',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                SizedBox(height: 16.h,),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 20.h),
              children: [
                StreamBuilder<QuerySnapshot<ScheduleNotificationModel>>(
                  stream: FbFirestoreController().readScheduleNotification(check: 'endDate',isEqualTo: formattedDate),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty ) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.notifications_none_sharp,
                                  color: Colors.black,
                                  size: 26.w,
                                ),
                                SizedBox(width: 10.w,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      AppText(text: snapshot.data!.docs[index].data().name,),
                                      SizedBox(height: 5.h,),
                                      AppText(text: snapshot.data!.docs[index].data().description,),
                                      SizedBox(height: 5.h,),
                                      AppText(text: snapshot.data!.docs[index].data().endDate,),
                                      SizedBox(
                                        height: 20.h,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          });

                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                StreamBuilder<QuerySnapshot<NormalNotificationModel>>(
                  stream: FbFirestoreController().readNormalNotification(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SizedBox();
                    } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty ) {
                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.notifications_none_sharp,
                                  color: Colors.black,
                                  size: 26.w,
                                ),
                                SizedBox(width: 10.w,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      AppText(text: snapshot.data!.docs[index].data().title,),
                                      SizedBox(height: 5.h,),
                                      AppText(text: snapshot.data!.docs[index].data().description,),

                                      SizedBox(
                                        height: 20.h,
                                      )
                                    ],
                                  ),
                                )
                              ],
                            );
                          });

                    } else {
                      return const SizedBox();
                    }
                  },
                ),
                /*ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.notifications_none_sharp,
                            color: Colors.black,
                            size: 26.w,
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                AppText(text: _messages[index].notification?.title ?? 'No Title',),
                                SizedBox(height: 5.h,),
                                AppText(text: _messages[index].notification?.title ?? 'No Title',),
                                SizedBox(
                                  height: 20.h,
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    }),*/
              ],
            ),
          ),
          SizedBox(height: 30.h,)
        ],
      ),
    );
  }
}
