import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tasty_booking/fb_controller/fb_auth_controller.dart';
import 'package:tasty_booking/model/fb_response.dart';
import 'package:tasty_booking/screens/auth_screens/login_screens/login_screen.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/validator/validator.dart';
import 'package:tasty_booking/wdgets/app_back_button.dart';
import 'package:tasty_booking/wdgets/app_elevated_button.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';
import 'package:tasty_booking/wdgets/base_text_field.dart';
import 'package:tasty_booking/wdgets/custom_app_loading.dart';

import '../../../model/main_category_model.dart';
import '../../../wdgets/custom_password_package.dart';
import '../../../wdgets/custom_password_package.dart';

class CreateNewAccountScreen extends StatefulWidget {
  const CreateNewAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewAccountScreen> createState() => _CreateNewAccountScreenState();
}

class _CreateNewAccountScreenState extends State<CreateNewAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Country country = CountryParser.parseCountryCode('SA');
  late TextEditingController _userNameEditingController;
  // late TextEditingController _CityEditingController;
  late TextEditingController _phoneEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _confirmPasswordEditingController;
  late TextEditingController newCategoryTextController;

  List<MainCategoryModel> mainCategory = <MainCategoryModel>[
    MainCategoryModel('الرياض', 'Entertainment'),
    MainCategoryModel('جدة', 'Bills'),
    MainCategoryModel('مكة', 'Basic Supplies'),
    MainCategoryModel('المدينة', 'Transportation'),
    MainCategoryModel('الدمام', 'Transportation'),
    MainCategoryModel('الخبر', 'Transportation'),
    MainCategoryModel('الظهران', 'Transportation'),
  ];
  String?_selectedCategoryId;

  bool obscure = true;
  bool obscure2 = true;
  bool approved = false;
  bool isLoading = false;
  String? phoneError;
  String? userNameIsError;
  String? emailIsError;
  String? CityIsError;
  String? passwordIsError;
  String? confPasswordIsError;
  String countryCode = '+966';
  String? countryFlag;
  String? userLat;
  String? userLong;
  String? userArea;
  String Address = 'search';




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameEditingController = TextEditingController();
    newCategoryTextController = TextEditingController();
    _phoneEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _confirmPasswordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameEditingController.dispose();
    newCategoryTextController.dispose();
    _phoneEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _confirmPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.zero,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 68.h,
                      ),
                      AppBackButton(
                        onTap: () => Navigator.pop(context),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      AppText(
                        text: context.localizations.create_new_account_title,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'DINNextLTArabic_bold',
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      BaseTextField(
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: SvgPicture.asset(
                            'assets/images/userNameIcon.svg',
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        type: TextInputType.name,
                        hint: context.localizations.user_name,
                        controller: _userNameEditingController,
                        validate: (value) => value!.validateName(context),
                        fieldTypes: FieldTypes.normal,
                      ),
                      /*AppTextField(
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
                        hintText: context.localizations.user_name,
                      ),*/
                      SizedBox(
                        height: 16.h,
                      ),
                      BaseTextField(
                        type: TextInputType.emailAddress,
                        hint: context.localizations.email,
                        controller: _emailEditingController,
                        validate: (value) => value!.validateEmail(context),
                        fieldTypes: FieldTypes.normal,
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: Icon(
                            Icons.email_outlined,
                            size: 24.sp,
                            color: Color(0XFF353A62),
                          ),
                        ),
                      ),
                      /*AppTextField(

                        controller: _emailEditingController,
                        errorText: emailIsError,
                        keyboardType: TextInputType.text,
                        onChanged: (p0) {
                          if (emailIsError != null) {
                            setState(() {
                              emailIsError = null;
                            });
                          }
                        },
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: Icon(
                            Icons.email_outlined,
                            size: 24.sp,
                            color: Color(0XFF353A62),
                          ),
                        ),
                        hintText: context.localizations.email,
                      ),*/
                      // SizedBox(
                      //   height: 16.h,
                      // ),
                      // AppDropDown<String>(
                      //   hint: 'اختار المنطقة',
                      //   onChanged: (String? value) {
                      //     setState(() {
                      //       _selectedCategoryId = value;
                      //       newCategoryTextController.clear();
                      //     });
                      //   },
                      //   color: _selectedCategoryId != null ? AppColors.primaryColor:AppColors.secondGrayColor,
                      //   value: _selectedCategoryId,
                      //   items: mainCategory.map(
                      //         (category) {
                      //       return DropdownMenuItem(
                      //         value: category.nameAr,
                      //         child: Text(category.nameAr),
                      //       );
                      //     },
                      //   ).toList(),
                      //   marginTop: 15.h,
                      // ),

                      // AppTextField(
                      //   controller: _CityEditingController,
                      //   errorText: CityIsError,
                      //   keyboardType: TextInputType.emailAddress,
                      //   onChanged: (p0) {
                      //     if (CityIsError != null) {
                      //       setState(() {
                      //         CityIsError = null;
                      //       });
                      //     }
                      //   },
                      //   prefixIcon: Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 18.h),
                      //     child: Icon(
                      //       Icons.location_city_rounded,
                      //       size: 24.sp,
                      //       color: Color(0XFF353A62),
                      //     ),
                      //   ),
                      //   hintText: 'المنطقه',
                      // ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // Row(
                      //   children: [
                      //     InkWell(
                      //       onTap: () {
                      //         showPicker();
                      //       },
                      //       child: Container(
                      //         height: 60.h,
                      //         padding: EdgeInsets.symmetric(horizontal: 8.w),
                      //         decoration: BoxDecoration(
                      //             borderRadius: BorderRadius.circular(15.r),
                      //             border: Border.all(
                      //                 width: 1.w,
                      //                 color: AppColors.secondGrayColor)),
                      //         child: Center(
                      //             child: Row(
                      //           children: [
                      //             AppText(
                      //               text: countryFlag ?? country.flagEmoji,
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 20,
                      //             ),
                      //             SizedBox(
                      //               width: 6.w,
                      //             ),
                      //             Column(
                      //               mainAxisAlignment: MainAxisAlignment.center,
                      //               children: [
                      //                 AppText(
                      //                   text: countryCode,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //                 SizedBox(
                      //                   height: 3.h,
                      //                 )
                      //               ],
                      //             ),
                      //           ],
                      //         )),
                      //       ),
                      //     ),
                      //     // SizedBox(
                      //     //   width: 8.w,
                      //     // ),
                      //     // Expanded(
                      //     //     child: AppTextField(
                      //     //   controller: _phoneEditingController,
                      //     //   keyboardType: TextInputType.phone,
                      //     //   hintText: context.localizations.phone,
                      //     //   errorText: phoneError,
                      //     //   onChanged: (p0) {
                      //     //     if (phoneError != null) {
                      //     //       setState(() {
                      //     //         phoneError = null;
                      //     //       });
                      //     //     }
                      //     //   },
                      //     // )),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 16.h,
                      // ),
                      Column(
                        children: [
                          BaseTextField(
                            prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child: SvgPicture.asset(
                                'assets/images/lockIcon.svg',
                                height: 24.h,
                                width: 24.w,
                              ),
                            ),
                            onChanged: (value) {
                              updatePasswordController(value);
                            },
                            type: TextInputType.visiblePassword,
                            hint: context.localizations.enter_password,
                            controller: _passwordEditingController,
                            focus: false,
                            errorText: passwordIsError,

                            // onSubmit: (){
                            //   print("7878998798798");
                            // },
                            // onFieldSubmitted: (value){
                            //   print("7878998798798$value");
                            //
                            //   setState(() {
                            //     isPasswordValidCheck =true;
                            //   });
                            // },
                            validate: (value) => value!.validatePassword(context),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              icon: Icon(
                                obscure ? Icons.visibility : Icons.visibility_off,
                              ),
                            ),
                            fieldTypes: obscure ? FieldTypes.password : FieldTypes.normal,
                          ),
                          _passwordEditingController.text.isEmpty
                              ? const SizedBox():CustomPasswordPackage(textController: _passwordEditingController,),

                        ],
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      BaseTextField(
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: SvgPicture.asset(
                            'assets/images/lockIcon.svg',
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        type: TextInputType.visiblePassword,
                        hint: context.localizations.enter_password_again,
                        controller: _confirmPasswordEditingController,
                        validate: (value) => value!.validatePasswordConfirm(
                            context,
                            pass: _confirmPasswordEditingController.text),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(
                                  () {
                                obscure2 = !obscure2;
                              },
                            );
                          },
                          icon: Icon(
                            obscure2 ? Icons.visibility : Icons.visibility_off,
                          ),
                        ),
                        fieldTypes:
                        obscure2 ? FieldTypes.password : FieldTypes.normal,
                      ),
                      /*AppTextField(
                        maxLines: 1,

                        controller: _confirmPasswordEditingController,
                        errorText: confPasswordIsError,
                        onChanged: (p0) {
                          if (confPasswordIsError != null) {
                            setState(() {
                              confPasswordIsError = null;
                            });
                          }
                        },
                        prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child: SvgPicture.asset(
                            'assets/images/lockIcon.svg',
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                        hintText: context.localizations.enter_password_again,
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              obscure2 = !obscure2;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: SvgPicture.asset(
                              obscure2
                                  ? 'assets/images/eyeClosed.svg'
                                  : 'assets/images/eyeOutline.svg',
                              height: 24.h,
                              width: 24.w,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        obscure: obscure2,
                      ),*/
                      SizedBox(
                        height: 20.h,
                      ),
                      SizedBox(
                        height: 26.h,
                      ),
                      AppElevatedButton(
                        text: context.localizations.join_text,
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await _performSignUp();
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                      const Spacer(),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10.r),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LogInScreen(),
                                ));
                          },
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: '${context.localizations.have_account} ',
                                  style: TextStyle(
                                      color: AppColors.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'DINNextLTArabic_Light'),
                                ),
                                TextSpan(
                                  text: context.localizations.login,
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'DINNextLTArabic_Light'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                    ]),
              ),
            ),
            Visibility(
                visible: isLoading == true, child: const CustomAppLoading())
          ],
        ),
      ),
    );
  }

  Future<void> _performSignUp() async {
    if (_checkData()) {
      Position position = await _getGeoLocationPosition();
      print('44444444');
      await getAddressFromLatLong(position);
      print('5555555555');
      if(
      userLat != null&&
      userLong != null&&userArea != null){
        print('6666666');
        await _registerUser();
      }
      // await _registerUser();
    }
  }

  bool _checkData() {
    if (_formKey.currentState!.validate()) {

      if (_passwordEditingController.text ==
          _confirmPasswordEditingController.text) {
        return true;

      } else if(_passwordEditingController.text !=
          _confirmPasswordEditingController.text){
        context.showSnackBar(
            message: context.localizations.password_does_not_match,
            error: true
        );

      }


    }
    if (_userNameEditingController.text.isEmpty) {
      setState(() {
        userNameIsError = '';
      });
    }

    if (_emailEditingController.text.isEmpty) {
      setState(() {
        emailIsError = '';
      });
    }
    if (_passwordEditingController.text.isEmpty) {
      setState(() {
        passwordIsError = '';
      });
    }
    if (_confirmPasswordEditingController.text.isEmpty) {
      setState(() {
        confPasswordIsError = '';
      });
    }


    context.showSnackBar(
        message: context.localizations.enter_required_data, error: true);
    return false;
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  Future<void> getAddressFromLatLong(Position position) async {
   try{
     List<Placemark> placemarks =
     await placemarkFromCoordinates(position.latitude, position.longitude);
     Placemark place = placemarks[0];
     Address =
     '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
     userArea = place.locality;
     userLat = position.latitude.toString();
     userLong = position.longitude.toString();
     setState(() {


     });
   } catch (e){
     context.showSnackBar(message: 'حدث خطأ ما!',error: true);
   }
  }
  Future<void> _registerUser() async {
    String username = _userNameEditingController.text.trim();
    String email = _emailEditingController.text.trim();
    String password = _passwordEditingController.text.trim();

    if (email.isNotEmpty &&
        username.isNotEmpty &&
        password.isNotEmpty
    ) {
        try {
          FbResponse fbResponse = await FbAuthController().createAccount(
              email: email,
              password: password,
              name: username,
              username: username,
              latitude: userLat!,
              longitude: userLong!,
              userArea: userArea!, phone: ''
          );
          if (fbResponse.success) {
            // Navigator.pop(context);
            // context.showSnackBar(
            //   message: 'تم التسجيل بنجاح الرجاء تفعيل بريدك الالكتروني',
            // );
            showDialog<String>(

              barrierDismissible: false,
              useSafeArea: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('تم التسجيل بنجاح'),
                content: const Text('تم التسجيل بنجاح الرجاء تفعيل بريدك الالكتروني'),
                actions: <Widget>[
                  // TextButton(
                  //   onPressed: () => Navigator.pop(context),
                  //   child: const Text('الغاء'),
                  // ),
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogInScreen(),
                        )),
                    child: const Text('نعم'),
                  ),
                ],
              ),
            );
          } else {
            context.showSnackBar(
                message: fbResponse.message, error: !fbResponse.success);
            print('000${fbResponse.message}');
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل في تسجيل المستخدم: $e')),
          );
          print('wwww ${e}');
        }



    }

    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.localizations.enter_required_data)),
      );
    }
  }

  void showPicker() {
    showCountryPicker(
      context: context,
      showPhoneCode: true,
      countryListTheme: CountryListThemeData(
          bottomSheetHeight: 600.h,
          inputDecoration: InputDecoration(
              constraints: BoxConstraints(maxHeight: 60.h),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                    BorderSide(width: 2.w, color: AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(
                  width: 0.50.w,
                  color: AppColors.secondGrayColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide:
                    BorderSide(width: 0.50.w, color: AppColors.secondGrayColor),
              ),
              prefixIcon: const Icon(Icons.search))),
      onSelect: (Country country) {
        setState(() {
          countryCode = '+${country.phoneCode}';
          countryFlag = country.flagEmoji;
        });
      },
    );
  }
  void updatePasswordController(String text) {
    setState(() {
      _passwordEditingController.text = text;
    });
  }
}
