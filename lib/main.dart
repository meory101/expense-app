import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasty_booking/fb_controller/fb_notifications.dart';
import 'package:tasty_booking/get_controller/language_getx_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tasty_booking/screens/core/splash_screen.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasty_booking/utils/notification_helper.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  if(Platform.isAndroid){
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }else{
    await Firebase.initializeApp();
  }
  if(Platform.isAndroid){
    await FbNotifications.initNotifications();

    final notificationService = NotificationService();
    await notificationService.init();
  }else{
  }

  tz.initializeTimeZones();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  /*const*/ MyApp({super.key});

  LanguageGetexController controller = Get.put<LanguageGetexController>(LanguageGetexController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 931),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<LanguageGetexController>(
          builder: (LanguageGetexController controller) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: const Color(0XFFFFFFFF)
              ),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                AppLocalizations.delegate
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('ar'),
              ],
              locale:controller.language != null?Locale(controller.language!):const Locale('ar'),
              // locale:const Locale('ar'),
              initialRoute: '/splash_screen',
              routes: {
                //BottomNavigationScreen
                '/splash_screen': (context) =>  SplashScreen(),
              },
            );
          },);

      },
    );
  }
}


