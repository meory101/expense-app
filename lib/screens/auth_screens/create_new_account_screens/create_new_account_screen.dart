import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/screens/auth_screens/login_screens/login_screen.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_back_button.dart';
import 'package:tasty_booking/wdgets/app_elevated_button.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';
import 'package:tasty_booking/wdgets/custom_app_loading.dart';
import 'package:tasty_booking/wdgets/outside_button_with_icons.dart';



class CreateNewAccountScreen extends StatefulWidget {
  const CreateNewAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateNewAccountScreen> createState() =>
      _CreateNewAccountScreenState();
}

class _CreateNewAccountScreenState
    extends State<CreateNewAccountScreen> {
  Country country = CountryParser.parseCountryCode('SA');
  late TextEditingController _userNameEditingController;
  late TextEditingController _phoneEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _confirmPasswordEditingController;
  bool obscure = true;
  bool obscure2 = true;
  bool approved = false;
  bool isLoading = false;
  String? phoneError;
  String? userNameIsError;
  String? emailIsError;
  String? passwordIsError;
  String? confPasswordIsError;
  String countryCode = '+966';
  String? countryFlag;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userNameEditingController = TextEditingController();
    _phoneEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _confirmPasswordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameEditingController.dispose();
    _phoneEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _confirmPasswordEditingController.dispose();
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
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 68.h,),
                    AppBackButton(onTap: () => Navigator.pop(context),),
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
                    AppTextField(
                      controller: _userNameEditingController,
                      errorText: userNameIsError,
                      onChanged: (p0) {
                        if(userNameIsError != null){
                          setState(() {
                            userNameIsError = null;
                          });
                        }},
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        child: SvgPicture.asset(
                          'assets/images/userNameIcon.svg',
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                      hintText: context.localizations.user_name,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap:(){
                            showPicker();
                          },
                          child: Container(
                            height: 60.h,
                            padding: EdgeInsets.symmetric(horizontal: 8.w),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.r),
                                border: Border.all(width: 1.w,color: AppColors.secondGrayColor)
                            ),
                            child: Center(child: Row(
                              children: [
                                AppText(text: countryFlag??country.flagEmoji,fontWeight: FontWeight.bold,fontSize: 20,),
                                SizedBox(width: 6.w,),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AppText(text: countryCode,fontWeight: FontWeight.bold,),
                                    SizedBox(height: 3.h,)
                                  ],
                                ),
                              ],
                            )),
                          ),
                        ),
                        SizedBox(width: 8.w,),
                        Expanded(child: AppTextField(
                          controller: _phoneEditingController,
                          keyboardType: TextInputType.phone,
                          hintText: context.localizations.phone,
                          errorText: phoneError,
                          onChanged: (p0) {
                            if(phoneError != null){
                              setState(() {
                                phoneError = null;
                              });
                            }},
                        )),

                      ],
                    ),
                    SizedBox(
                      height: 16.h,
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
                        child: Icon(Icons.email_outlined,size: 24.sp,color: Color(0XFF353A62),),
                      ),
                      hintText: context.localizations.email,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    AppTextField(
                      controller: _passwordEditingController,
                      obscure: obscure,
                        errorText: passwordIsError,
                        onChanged: (p0) {
                          if(passwordIsError != null){
                            setState(() {
                              passwordIsError = null;
                            });
                          }},
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.h),
                        child: SvgPicture.asset(
                          'assets/images/lockIcon.svg',
                          height: 24.h,
                          width: 24.w,
                        ),
                      ),
                      hintText: context.localizations.enter_password,
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscure = !obscure;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: SvgPicture.asset(
                            obscure
                                ? 'assets/images/eyeClosed.svg'
                                : 'assets/images/eyeOutline.svg',
                            height: 24.h,
                            width: 24.w,
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    AppTextField(
                      controller: _confirmPasswordEditingController,
                      errorText: confPasswordIsError,
                      onChanged: (p0) {
                        if(confPasswordIsError != null){
                          setState(() {
                            confPasswordIsError = null;
                          });
                        }},
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
                    ),
                    SizedBox(
                      height: 20.h,
                    ),

                    SizedBox(height: 26.h,),
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
            Visibility(
                visible: isLoading == true,
                child: const CustomAppLoading())
          ],
        ),
      ),
    );
  }

  Future<void> _performSignUp() async {
    if (_checkData()) {
      if(_acceptedTerms()){
        await _signUp();
      }
    }
  }

  bool _checkData() {
    if (_userNameEditingController.text.isNotEmpty &&
        _phoneEditingController.text.isNotEmpty &&
        _emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty &&
        _confirmPasswordEditingController.text.isNotEmpty) {
      if (_passwordEditingController.text ==
          _confirmPasswordEditingController.text) {
        return true;

      } else {
        context.showSnackBar(
            message: context.localizations.password_does_not_match,
            error: true);
        return false;
      }
    }
    if(_userNameEditingController.text.isEmpty){
      setState(() {
        userNameIsError = '';
      });
    }
    if(_phoneEditingController.text.isEmpty){
      setState(() {
        phoneError = '';
      });
    }
    if(_emailEditingController.text.isEmpty){
      setState(() {
        emailIsError = '';
      });
    }
    if(_passwordEditingController.text.isEmpty){
      setState(() {
        passwordIsError = '';
      });
    }
    if(_confirmPasswordEditingController.text.isEmpty){
      setState(() {
        confPasswordIsError = '';
      });
    }
    context.showSnackBar(
        message: context.localizations.enter_required_data, error: true);
    return false;
  }

  bool _acceptedTerms() {
    if(approved==true){
      return true;
    }else{
      context.showSnackBar(
          message: context.localizations.please_agree_to_the_rules_and_conditions,
          error: true);
      return false;
    }
  }

  Future<void> _signUp() async {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationPhoneNumberScreen(),));
/*    ApiResponse apiResponse = await AuthApiController().register(
      name: _userNameEditingController.text,
      mobile: _phoneEditingController.text,
      email: _emailEditingController.text,
      password: _passwordEditingController.text,
      retypePassword: _confirmPasswordEditingController.text,
    );
    if (apiResponse.success) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const VerificationPhoneNumberScreen(),));
    } else {
      context.showSnackBar(
          message: apiResponse.message, error: !apiResponse.success);
    }*/
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
                borderSide: BorderSide(width: 2.w, color:  AppColors.primaryColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(width: 0.50.w, color:  AppColors.secondGrayColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: BorderSide(width: 0.50.w, color:  AppColors.secondGrayColor),
              ),
              prefixIcon: const Icon(Icons.search)
          )
      ),
      onSelect: (Country country) {
        setState(() {
          countryCode = '+${country.phoneCode}';
          countryFlag = country.flagEmoji;
        });
      },
    );
  }
}
