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
import 'delete_account_screen.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool notificationOn = true;
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

                AppText(text: 'تعديل بيانات الحساب',fontWeight: FontWeight.bold,),
                Text(''),

              ],
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100.h,),
                Container(
                  child:   SvgPicture.asset('assets/images/editphoto.svg',height:241.h,width: 241.w, ),
                ),
                AppTextField(
                  controller: _emailEditingController,
                  errorText: emailIsError,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (p0) {
                    if(emailIsError != null){
                      setState(() {
                        emailIsError = null;
                      });
                    }},
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(vertical: 18.h),
                    child: Icon(Icons.account_circle,size: 24.sp,color: Color(0XFF353A62),),
                  ),
                  hintText: 'محمد قنوع',
                ),
                SizedBox(height: 20.h,),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => DeletaAccountScreen()));
                  },
                  child: Container(
                    padding: EdgeInsets.only(right: 10.w),
                    height: 100.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                      border: Border.all(color:AppColors.secondGrayColor )

                      ,),

                    child: Row(
                      children: [
                        // SvgPicture.asset('assets/images/deleteAccount.svg',height:40.h,width: 40.w, ),
                        Image.asset('assets/images/deleteAccount1.png',height: 30.h,width: 30.w,),
                        SizedBox(width: 14.w,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(text: 'حذف الحساب نهائي',fontWeight: FontWeight.bold,color: Colors.red,),
                            AppText(text: 'سوف تفقد جميع بياناتك وطلباتك بشكل نهائي ....',fontWeight: FontWeight.w100,fontSize: 12,color: Color(0xff94A3B8),),


                          ],
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),





          ],
        ),
      ),
bottomNavigationBar:
Padding(
  padding:  EdgeInsets.all(20.h),
  child: Container(
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppElevatedButton(
          width: 180.w,
          text: 'حفظ',
          onPressed: () async {

          },
        ),
        AppElevatedButton(
          backgroundColor: Colors.white,
          width: 180.w,
          text: 'الغاء',
          textColor:AppColors.grayColor,
          side:BorderSide(color: AppColors.grayColor),
          onPressed: () async {

          },
        ),
      ],
    ),
  ),
),
    );
  }
}
