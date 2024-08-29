import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/screens/home_screens/bottom_navigation_bar.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/style/app_colors.dart';


import '../auth_screens/login_screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3),() {
      bool isLoggedIn=SharedPrefController().getValueFor(key: PrefKeys.loggedIn.name)??false;
      if(isLoggedIn){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const BottomNavigationScreen(),));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  const LogInScreen(),));
      }

    },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset('assets/images/splashBackGround.png',fit: BoxFit.cover,),
          ),
          Center(
            child: SizedBox(
                height: 60.h,
                width: 60.w,
                child: CircularProgressIndicator(
                  color: AppColors.primaryColor,
                  strokeWidth: 5.w,
                  strokeCap: StrokeCap.round,
                  backgroundColor: Colors.white.withOpacity(0.1),
                )),
          ),
        ],
      ),
    );
  }
}
