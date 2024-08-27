import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tasty_booking/get_controller/language_getx_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tasty_booking/screens/core/splash_screen.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
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


