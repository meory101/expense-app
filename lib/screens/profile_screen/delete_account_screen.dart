import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

import '../../wdgets/app_back_button.dart';
import '../../wdgets/app_elevated_button.dart';
import '../../wdgets/app_text_field.dart';

class DeletaAccountScreen extends StatefulWidget {
  const DeletaAccountScreen({super.key});

  @override
  State<DeletaAccountScreen> createState() => _DeletaAccountScreenState();
}

class _DeletaAccountScreenState extends State<DeletaAccountScreen> {
  bool notificationOn = true;
  int? currentIndex;
  bool isCurrentIndex=false;
  late TextEditingController _emailEditingController;
  String? emailIsError;

@override
  void initState() {
    // TODO: implement initState
  _emailEditingController = TextEditingController();

  super.initState();
  }
  @override
  void dispose() {
    _emailEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Padding(
        padding:  EdgeInsets.all(20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 40.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBackButton(onTap: () => Navigator.pop(context),),

                AppText(text: 'حذف الحساب',fontWeight: FontWeight.bold,),
                Text(''),

              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h,),
                Container(
                  child:  Image.asset('assets/images/deleteAccount1.png',height: 166.h,width: 166.w,),

                ),
        GestureDetector(
          onTap: (){
            currentIndex=0;
            isCurrentIndex=!isCurrentIndex;
            setState(() {

            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 24.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: const Color(0xFFF4F4F4),width: 1)
            ),
            child:
            Column(
              children: [
                Row(
                  children: [
                    Expanded(child: Text('حذف حسابك نهائي !!',
                        style: TextStyle(
                            fontFamily: "DINNextLTArabic_bold",
                            color: AppColors.blackColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                            fontStyle: FontStyle.normal
                        )
                    )),
                    SizedBox(width: 12.w),
                    currentIndex==0&&isCurrentIndex?
                    SvgPicture.asset("assets/images/ArrowDown2.svg"):
                    SvgPicture.asset("assets/images/ArrowRight2.svg")

                  ],
                ),
                currentIndex==0&&isCurrentIndex?Column(
                  children: [
                    SizedBox(height: 16.h),
                    Container(
                      height: 1.h,
                      color: Color(0xFFEEEEEE),
                    ),
                    SizedBox(height: 16.h),
                    Text('سوف تفقد بياناتك بشكل نهائي من خلال حذف حسابك “  أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                      style: TextStyle(
                          fontFamily: "DINNextLTArabic_Light",
                          color: AppColors.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          fontStyle: FontStyle.normal
                      ),
                    )
                  ],
                ):SizedBox(height: 0.h,)

              ],
            ),
          ),
        ),
              ],
            ),





          ],
        ),
      ),
bottomNavigationBar:
Padding(
  padding:  EdgeInsets.all(20.h),
  child: Container(
    child:  AppElevatedButton(
      width: 180.w,
      text: 'حذف الحساب',
      backgroundColor: Colors.red,

      onPressed: () async {

      },
    ),
  ),
),
    );
  }
}
