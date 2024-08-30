import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  static const LatLng _ummAlquraUniversityLocation =
      LatLng(25.276987, 55.296249);
  BitmapDescriptor? _customIcon;
  bool onMarkTap = false;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    _customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(200.w, 130.h)),
      'assets/images/events2.png',

    );
    setState(() {});
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
                    Spacer(),
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

                AppText(
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
            child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 22.w,vertical: 20.h),

                itemCount: 23,
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
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 20.h,
                              width:80.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Colors.grey.shade200,
                                  ])),),
                            SizedBox(height: 5.h,),
                            Container(
                              height: 20.h,
                              width:150.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Colors.grey.shade200,
                                  ])),),
                            SizedBox(
                              height: 20.h,
                            )
                          ],
                        ),
                      )
                    ],
                  );
                }),
          ),
          SizedBox(height: 30.h,)
        ],
      ),
    );
  }
}
