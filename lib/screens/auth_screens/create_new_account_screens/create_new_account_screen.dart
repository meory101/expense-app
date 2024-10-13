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
import 'package:tasty_booking/wdgets/base_text_field.dart';
import 'package:tasty_booking/wdgets/custom_app_loading.dart';
import '../../../model/main_category_model.dart';
import '../../../wdgets/custom_password_package.dart';

class CreateNewAccountScreen extends StatefulWidget {
  const CreateNewAccountScreen({super.key});

  @override
  State<CreateNewAccountScreen> createState() => _CreateNewAccountScreenState();
}

class _CreateNewAccountScreenState extends State<CreateNewAccountScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Country country = CountryParser.parseCountryCode('SA');
  late TextEditingController _userNameEditingController;
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
  String? _selectedCategoryId;

  bool obscure = true;
  bool obscure2 = true;
  bool approved = false;
  bool isLoading = false;
  String? phoneError;
  String? userNameIsError;
  String? emailIsError;
  String? cityIsError;
  String? passwordIsError;
  String? confPasswordIsError;
  String countryCode = '+966';
  String? countryFlag;
  String? userLat;
  String? userLong;
  String? userArea;
  String address = 'search';

  @override
  void initState() {
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

  bool checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 68.h),
                AppBackButton(onTap: () => Navigator.pop(context)),
                SizedBox(height: 40.h),
                AppText(
                  text: context.localizations.create_new_account_title,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'DINNextLTArabic_bold',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
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
                SizedBox(height: 16.h),
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
                SizedBox(height: 16.h),
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
                    ? const SizedBox()
                    : CustomPasswordPackage(

                  textController: _passwordEditingController,
                ),
                SizedBox(height: 16.h),
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
                    pass: _confirmPasswordEditingController.text,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscure2 = !obscure2;
                      });
                    },
                    icon: Icon(
                      obscure2 ? Icons.visibility : Icons.visibility_off,
                    ),
                  ),
                  fieldTypes: obscure2 ? FieldTypes.password : FieldTypes.normal,
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(
                          color: AppColors.grayBorderColor,
                          width: 1,
                        ),
                      ),
                      value: checkedValue,
                      onChanged: (value) {
                        setState(() {
                          checkedValue = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'هل توافق على شروط وسيايات التطبيق ؟',
                      style: TextStyle(
                        color: AppColors.blackColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'DINNextLTArabic_Light',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 26.h),
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
                SizedBox(height: 4.h),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10.r),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogInScreen(),
                        ),
                      );
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
                              fontFamily: 'DINNextLTArabic_Light',
                            ),
                          ),
                          TextSpan(
                            text: context.localizations.login,
                            style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'DINNextLTArabic_Light',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: isLoading,
        child: const CustomAppLoading(),
      ),
    );
  }

  Future<void> _performSignUp() async {
    if (_checkData()) {
      Position position = await _getGeoLocationPosition();
      await getAddressFromLatLong(position);
      if (userLong != null && userLong != null) {
        await _registerUser();
      }
    }
  }

  bool _checkData() {
    if (_formKey.currentState!.validate() && checkedValue == true) {
      if (_passwordEditingController.text ==
          _confirmPasswordEditingController.text) {
        return true;
      } else if (_passwordEditingController.text !=
          _confirmPasswordEditingController.text) {
        context.showSnackBar(
            message: context.localizations.password_does_not_match,
            error: true);
      }
    }
    if (checkedValue == false) {
      context.showSnackBar(
          message: "الرجاء الموافقة على سياسات التطبيق", error: true);
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
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> getAddressFromLatLong(Position position) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      address =
      '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      userArea = place.locality;
      userLat = position.latitude.toString();
      userLong = position.longitude.toString();
      setState(() {});
    } catch (e) {
      context.showSnackBar(message: 'حدث خطأ ما!', error: true);
    }
  }

  Future<void> _registerUser() async {
    if(strength >0.8){
      String username = _userNameEditingController.text.trim();
      String email = _emailEditingController.text.trim();
      String password = _passwordEditingController.text.trim();

      if (email.isNotEmpty && username.isNotEmpty && password.isNotEmpty) {
        try {
          FbResponse fbResponse = await FbAuthController().createAccount(
              email: email,
              password: password,
              name: username,
              username: username,
              latitude: userLat ?? 0.0.toString(),
              longitude: userLong ?? 0.0.toString(),
              userArea: userArea ?? "",
              phone: '');
          if (fbResponse.success) {
            strength == 0;
            showDialog<String>(
              barrierDismissible: false,
              useSafeArea: false,
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('تم التسجيل بنجاح'),
                content: const Text('تم التسجيل بنجاح الرجاء تفعيل بريدك الالكتروني'),
                actions: <Widget>[
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
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('فشل في تسجيل المستخدم: $e')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.localizations.enter_required_data)),
        );
      }
    }else{
      context.showSnackBar(
          message: "كلمة مرور ضعيفة",
          error: true);
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
                borderSide: BorderSide(
                    width: 0.50.w, color: AppColors.secondGrayColor),
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