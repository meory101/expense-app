import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tasty_booking/screens/home_screens/explore_screen.dart';
import 'package:tasty_booking/screens/home_screens/nearest_restaurants_screen.dart';
import 'package:tasty_booking/screens/home_screens/reservations_screen.dart';
import 'package:tasty_booking/screens/home_screens/settings_screen.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/bn_screen_model.dart';
import 'package:tasty_booking/utils/helpers.dart';


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  // HomeGetController controller = Get.put<HomeGetController>(HomeGetController());
  int _selectedPageIndex = 0;
  List<BnScreen> _getScreens(BuildContext context){
    final List<BnScreen> _screens = <BnScreen>[
      //const BnScreen(title: 'الرئيسية', widget: InactiveAccountHomeScreen()),
      BnScreen(title: context.localizations.explore, widget: const ExploreScreen()),
      BnScreen(title: context.localizations.nearest_restaurants, widget: const NearestRestaurantsScreen()),
      BnScreen(title: context.localizations.reservations, widget: const ReservationsScreen()),
      BnScreen(title: context.localizations.settings, widget: const SettingsScreen()),
    ];
    return _screens;
  }


@override
  void dispose() {
   // Get.delete<HomeGetController>(force: true);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreens(context)[_selectedPageIndex].widget,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: SizedBox(
          height: 102.h,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            enableFeedback: false,
            selectedItemColor: AppColors.primaryColor,
            selectedIconTheme: const IconThemeData(
              color: Colors.black,
            ),
            selectedLabelStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'DINNextLTArabic_Light',
              color: AppColors.primaryColor,
              height: 1.7.h
            ),
            elevation: 0,
            unselectedLabelStyle:TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                fontFamily: 'DINNextLTArabic_Light',
                color: const Color(0XFFC9CEDC),
                height: 1.7.h
            ),
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: (int selectedPageIndex) {
              setState(() {
                _selectedPageIndex = selectedPageIndex;
              });
            },
            currentIndex: _selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    SvgPicture.asset('assets/images/explore.svg',height: 24.h,width: 24.w,colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
                    SizedBox(height: 5.h,),
                  ],
                ),
                icon: Column(
                  children: [
                    SvgPicture.asset('assets/images/explore.svg',height: 24.h,width: 24.w,),
                    SizedBox(height: 5.h,),
                  ],
                ),
                label: context.localizations.explore,
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    SvgPicture.asset('assets/images/nearestRestaurants.svg',height: 24.h,width: 24.w,colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
                    SizedBox(height: 5.h,),
                  ],
                ),
                icon: Column(
                  children: [
                    SvgPicture.asset('assets/images/nearestRestaurants.svg',height: 24.h,width: 24.w,),
                    SizedBox(height: 5.h,),
                  ],
                ),
                label: context.localizations.nearest_restaurants,
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    SvgPicture.asset('assets/images/reservations.svg',height: 24.h,width: 24.w,colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
                    SizedBox(height: 5.h,),
                  ],
                ),
                icon: Column(
                  children: [
                    SvgPicture.asset('assets/images/reservations.svg',height: 24.h,width: 24.w,),
                    SizedBox(height: 5.h,),
                  ],
                ),
                label: context.localizations.reservations,
              ),
              BottomNavigationBarItem(
                activeIcon: Column(
                  children: [
                    SvgPicture.asset('assets/images/settingsIcon.svg',height: 24.h,width: 24.w,colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),),
                    SizedBox(height: 5.h,),
                  ],
                ),
                icon: Column(
                  children: [
                    SvgPicture.asset('assets/images/settingsIcon.svg',height: 24.h,width: 24.w,),
                    SizedBox(height: 5.h,),
                  ],
                ),
                label: context.localizations.settings,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
