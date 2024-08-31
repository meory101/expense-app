
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/fb_controller/fb_notifications.dart';
import 'package:tasty_booking/screens/home_screens/add_new_category_screen.dart';
import 'package:tasty_booking/screens/home_screens/debts_screen.dart';
import 'package:tasty_booking/screens/home_screens/home_screen.dart';
import 'package:tasty_booking/screens/home_screens/notification_screen.dart';
import 'package:tasty_booking/screens/home_screens/profile_screen.dart';
import 'package:tasty_booking/screens/profile_screen/common_questions_screen.dart';
import 'package:tasty_booking/screens/profile_screen/love_screen.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/bn_screen_model.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);


  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> with FbNotifications{
  int _selectedPageIndex = 0;
  final List<BnScreen> _screens = <BnScreen>[
    const BnScreen(title: 'Home', widget: HomeScreen()),
    const BnScreen(title: 'Notification', widget: NotificationScreen()),
    const BnScreen(title: 'add', widget: AddNewCategoryScreen()),
    const BnScreen(title: 'debts', widget: DebtsScreen()),
    const BnScreen(title: 'Profile', widget: ProfileScreen()),
  ];
  @override
  void initState() {
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _screens[_selectedPageIndex].widget,
      bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.white,
          color: Color(0XFFC8C8D3),
          style: TabStyle.fixedCircle,
          top: -30,
          curveSize: 85,
          height: 75.h,
          onTap: (index) {
            setState(() {
              _selectedPageIndex = index;
            });
          },
          activeColor: AppColors.primaryColor,
          items: [
            TabItem(icon: SvgPicture.asset(
              "assets/images/homeNavIcon.svg",
              width: 20.w,
              height: 20.h,
              colorFilter:  ColorFilter.mode(_selectedPageIndex==0?AppColors.primaryColor:Color(0XFFC8C8D3), BlendMode.srcIn),
            ), title: 'الرئيسية'),
            TabItem(icon: SvgPicture.asset(
              "assets/images/alarmNavIcon.svg",
              width: 20.w,
              height: 20.h,
              colorFilter:  ColorFilter.mode(_selectedPageIndex==1?AppColors.primaryColor:Color(0XFFC8C8D3), BlendMode.srcIn),
            ), title: 'الإشعارات'),


            TabItem(
              icon: Container(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  shape: BoxShape.circle,),
                child: Center(child: Icon(Icons.add,size: 40.w,color: Colors.white,),),
              ),
              title: 'Add',
            ),

            TabItem(icon: SvgPicture.asset(
              "assets/images/bagIcon.svg",
              width: 20.w,
              height: 20.h,
              colorFilter:  ColorFilter.mode(_selectedPageIndex==3?AppColors.primaryColor:Color(0XFFC8C8D3), BlendMode.srcIn),
            ), title: 'الديون'),
            TabItem(icon: SvgPicture.asset(
              "assets/images/singleNavIcon.svg",
              width: 20.w,
              height: 20.h,
              colorFilter:  ColorFilter.mode(_selectedPageIndex==4?AppColors.primaryColor:Color(0XFFC8C8D3), BlendMode.srcIn),
            ), title: 'الحساب'),
          ]),
    );
  }
  Future<void> _showDialog(BuildContext context) async {
    showDialog(
        context: context,
        barrierColor: Colors.white60,
        builder: (_) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                content: Column(
                  children: [
                    Text(
                      'تهانينا',
                      style: TextStyle(
                        fontFamily: 'DroidArabic_Bold',
                        fontSize: 46.0.sp,
                        color: AppColors.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16.h,),
                    Image.asset('assets/factoryImages/successLogin.png',height: 186.h,width: 242.w,),
                    SizedBox(height: 20.h,),
                    Text(
                      'تم تسجيل دخولك بنجاح',
                      style: TextStyle(
                        fontFamily: 'DroidArabic_Bold',
                        fontSize: 19.0.sp,
                        color: AppColors.primaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 33.h,),
    /*                CustomAppButton(
                      title: 'الإنتقال إلى الرئيسية',
                      onPress: () {
                        Navigator.pop(context);

                      },
                    ),*/
                  ],
                ),
              );
            },
          );
        });
  }
/*  Future<void> _showMyDialog() async {
    return showDialog<void>(
      barrierColor: const Color(0xff4C4C4C).withOpacity(0.91),
      context: context,
      // barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Column(
            children: [
              Text(
                'تهانينا',
                style: TextStyle(
                  fontFamily: 'DroidArabic_Bold',
                  fontSize: 46.0.sp,
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h,),
              Image.asset('assets/factoryImages/successLogin.png',height: 186.h,width: 242.w,),
              SizedBox(height: 20.h,),
              Text(
                'تم تسجيل دخولك بنجاح',
                style: TextStyle(
                  fontFamily: 'DroidArabic_Bold',
                  fontSize: 19.0.sp,
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 33.h,),
              CustomAppButton(
                title: 'الإنتقال إلى الرئيسية',
                onPress: () {
                  Navigator.pop(context);

                },
              ),
            ],
          ),
        );
      },
    );
  }*/
}
