import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/screens/home_screens/categories_screen.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_elevated_button.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';

import '../../fb_controller/fb_auth_controller.dart';
import '../../model/fb_response.dart';
import '../../shared_preferences/shared_prefrences_controller.dart';
import '../../wdgets/custom_app_loading.dart';
import 'bottom_navigation_bar.dart';

class AddDebtsScreen extends StatefulWidget {
  const AddDebtsScreen({super.key});

  @override
  State<AddDebtsScreen> createState() => _AddDebtsScreenState();
}

class _AddDebtsScreenState extends State<AddDebtsScreen> {
  late TextEditingController _userNameEditingController;
  late TextEditingController _Cost1EditingController;
  late TextEditingController _Cost2EditingController;
  late TextEditingController _noteEditingController;
  String? userNameIsError;
  String? Cost1IsError;
  String? Cost2IsError;
  String? NoteIsError;
  String? Dateend;
  bool isLoading = false;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameEditingController = TextEditingController();
    _Cost1EditingController = TextEditingController();
    _Cost2EditingController = TextEditingController();
    _noteEditingController = TextEditingController();

  }

  @override
  void dispose() {
    _userNameEditingController.dispose();
    _Cost1EditingController.dispose();
    _Cost2EditingController.dispose();
    _noteEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,

          body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 24.w,),
                  decoration: const BoxDecoration(color: AppColors.primaryColor),
                  child: Column(
                    children: [
                      SizedBox(height: 50.h,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: ' اضافة دين',
                            fontFamily: 'DINNextLTArabic_bold',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          InkWell(
                              onTap: (){
                                Navigator.of(context).pop();
                              },
                              child: Icon(Icons.arrow_forward,color: Colors.white,))

                        ],
                      ),
                      SizedBox(height: 16.h,),




                    ],
                  ),
                ),


                SizedBox(height: 30.h,),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w,),
                  child:

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 24.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: AppColors.primaryColor,width: 0.5.w),
                        borderRadius: BorderRadius.circular(16.r),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(0, 3))
                        ]
                    ),
                    child: Column(
                      children: [
                        AppTextField(
                          controller: _userNameEditingController,
                          errorText: userNameIsError,
                          onChanged: (p0) {
                            if (userNameIsError != null) {
                              setState(() {
                                userNameIsError = null;
                              });
                            }
                          },
                          prefixIcon: Padding(
                            padding: EdgeInsets.symmetric(vertical: 18.h),
                            child: SvgPicture.asset(
                              'assets/images/userNameIcon.svg',
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                          hintText: 'اسم الدائن ',
                        ),
                        SizedBox(height: 16.h,),

                        AppTextField(
                          keyboardType: TextInputType.number,

                          controller: _Cost1EditingController,
                          errorText: Cost1IsError,
                          onChanged: (p0) {
                            if (Cost1IsError != null) {
                              setState(() {
                                Cost1IsError = null;
                              });
                            }
                          },
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child: Icon(Icons.attach_money)
                          ),
                          hintText: 'مبلغ الدين كامل ',
                        ),
                        SizedBox(height: 16.h,),

                        AppTextField(
                          keyboardType: TextInputType.number,
                          controller: _Cost2EditingController,
                          errorText: Cost2IsError,
                          onChanged: (p0) {
                            if (Cost2IsError != null) {
                              setState(() {
                                Cost2IsError = null;
                              });
                            }
                          },
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child: Icon(Icons.attach_money)
                          ),
                          hintText: 'المبلغ المسدد من الدين ',
                        ),
                        SizedBox(height: 16.h,),


                        EasyDateTimeLine(
                          initialDate: DateTime.now(),
                          headerProps: const EasyHeaderProps(showHeader: true),
                          locale: 'ar',
                          activeColor: AppColors.primaryColor,
                          dayProps: EasyDayProps(
                              height: 80.h,
                              width: 62.w,

                              todayHighlightColor: AppColors.primaryColor,
                              borderColor: const Color(0XFFF6F6F6),
                              landScapeMode: false,
                              inactiveDayStyle: DayStyle(
                                  borderRadius: 8.r,
                                  dayNumStyle: TextStyle(
                                    color: const Color(0XFF828282),
                                    fontFamily: 'DINNextLTArabic_Light',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  )
                              ),
                              activeDayStyle: DayStyle(
                                borderRadius: 8.r,

                                dayNumStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'DINNextLTArabic_Light',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500
                                ),
                                monthStrStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'DINNextLTArabic_Light',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500
                                ),
                                dayStrStyle: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'DINNextLTArabic_Light',
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              todayStyle: DayStyle(
                                  borderRadius: 8.r,
                                  dayNumStyle: TextStyle(
                                      color: const Color(0XFF828282),
                                      fontFamily: 'DINNextLTArabic_Light',
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500
                                  )
                              )
                          ),
                          onDateChange: (selectedDate) {
                            //`selectedDate` the new date selected.
                            Dateend = selectedDate.toString().substring(0,10);
                            print('selectedDate ${selectedDate.toString().substring(0,10)}');
                          },
                        ),

                        SizedBox(height: 30.h,),


                        AppTextField(
                          height  : 200.h,
                          maxLines: 10,
                          // minLines: 10,
                          // maxLength: 5,

                          controller: _noteEditingController,
                          errorText: NoteIsError,
                          onChanged: (p0) {
                            if (NoteIsError != null) {
                              setState(() {
                                NoteIsError = null;
                              });
                            }
                          },

                          hintText: 'اضافه ملاحظات على هذا الدين ',
                        ),
                        SizedBox(height: 50.h,),

                        AppElevatedButton(
                            text: 'اضافة',
                            onPressed:()async{
                              setState(() {
                                isLoading = true;
                              });
                              await _addDebtsUser();
                              setState(() {
                                isLoading = false;
                              });
                            }
                        )

                      ],
                    ),
                  ),


                ),

                SizedBox(height: 30.h,)
              ],
            ),
            Visibility(
                visible: isLoading == true,
                child: const CustomAppLoading()),
          ],
        )


      ),
    );

  }
  Future<void> _addDebtsUser() async {
    String Name = _userNameEditingController.text.trim();
    String Cost1 = _Cost1EditingController.text.trim();
    String Cost2 = _Cost2EditingController.text.trim();
    String Date = Dateend!;
    String Note = _noteEditingController.text.trim();
    String UserId = SharedPrefController().getValueFor(key: PrefKeys.userId.name);


    if (
    Name.isNotEmpty &&
        Cost1.isNotEmpty &&
        Cost2.isNotEmpty &&
        Date.isNotEmpty &&
        Note.isNotEmpty) {
      try {
        print('12311');
        await _firestore.collection('Debts').doc(UserId).set({
          // 'attachment': attachment,
          'Name': Name,
          'Amount_Depts': Cost1,
          'Amount_Paid_Depts': Cost2,
          'Date': Date,
          'Note': Note,
          'UserID':UserId,

        });
        print('123333');
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => BottomNavigationScreen(),), (route) => false,);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم اضافه الدين بنجاح')),

        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${"فشل في اضافه الدين , يرجى المحاوله لاحقا"} $e')),
        );
        print('wwww ${e}');

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.localizations.enter_required_data)),
      );
    }
  }

}
