import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/fb_controller/fb_firestore.dart';
import 'package:tasty_booking/model/expense_amount_model.dart';
import 'package:tasty_booking/model/expense_model.dart';
import 'package:tasty_booking/model/main_category_model.dart';
import 'package:tasty_booking/screens/auth_screens/create_new_account_screens/create_new_account_screen.dart';
import 'package:tasty_booking/screens/home_screens/categories_screen.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/wdgets/app_elevated_button.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';
import 'package:tasty_booking/wdgets/button_with_border.dart';
import 'package:tasty_booking/wdgets/custom_app_loading.dart';
import '../../style/app_colors.dart';
import '../../wdgets/app_drop_down.dart';
import 'home_screen.dart';

class AddNewCategoryScreen extends StatefulWidget {
  const AddNewCategoryScreen({super.key});

  @override
  State<AddNewCategoryScreen> createState() => _AddNewCategoryScreenState();
}

class _AddNewCategoryScreenState extends State<AddNewCategoryScreen> {
  late TextEditingController costTextController;
  late TextEditingController HightcostTextController;
  late TextEditingController newCategoryTextController;
  late TextEditingController nameController;
  String?_selectedCategoryId;
  List<MainCategoryModel> mainCategory = <MainCategoryModel>[
    MainCategoryModel('ترفيه', 'Entertainment'),
    MainCategoryModel('فواتير', 'Bills'),
    MainCategoryModel('مستلزمات اساسية', 'Basic Supplies'),
    MainCategoryModel('مواصلات', 'Transportation'),
  ];
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('tarfeeh ${tarfeeh}');
    print('foateer ${foateer}');
    print('mostlzamat ${mostlzamat}');
    print('moasalat ${moasalat}');
    costTextController = TextEditingController();
    HightcostTextController = TextEditingController();
    newCategoryTextController = TextEditingController();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    costTextController.dispose();
    HightcostTextController.dispose();
    newCategoryTextController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 10.h),
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Column(
                children: [
                  SizedBox(height: 40.h,),
                  const AppText(
                    text: 'اضافة مصروف جديد',
                    fontFamily: 'DINNextLTArabic_bold',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16.h,),
                ],
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
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
                      controller: costTextController,
                      hintText: 'المصروف (رقم) *',
                      keyboardType: TextInputType.number,
                      prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child:  Image.asset('assets/images/SRA.jpeg')
                      ),
                      // prefixIcon: Image.asset('assets/images/SRA.jpeg',height: 5.h,width: 5.w,),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    AppTextField(
                      controller: nameController,
                      hintText: 'المصروف (اسم) *',
                      keyboardType: TextInputType.text,
                      prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child:  Image.asset('assets/images/SRA.jpeg')
                      ),
                      // prefixIcon: Image.asset('assets/images/SRA.jpeg',height: 5.h,width: 5.w,),
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    AppDropDown<String>(
                      hint: 'اختار تصنيف',
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCategoryId = value;
                          newCategoryTextController.clear();
                        });
                      },
                      color: _selectedCategoryId != null ? AppColors.primaryColor:AppColors.secondGrayColor,
                      value: _selectedCategoryId,
                      items: mainCategory.map(
                        (category) {
                          return DropdownMenuItem(
                            value: category.nameEn,
                            child: Text(category.nameAr),
                          );
                        },
                      ).toList(),
                      marginTop: 15.h,
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    const Align(
                      alignment: AlignmentDirectional.centerStart,
                        child: AppText(text: 'في حال عدم اختيار تصنيف اساسي يرجى اضافة التصنيف المطلوب',fontSize: 12,textAlign: TextAlign.start,)),
                    SizedBox(
                      height: 10.h,
                    ),
                    AppTextField(
                      controller: newCategoryTextController,
                      hintText: 'تصنيف اخر',
                      keyboardType: TextInputType.text,
                      enabled: _selectedCategoryId==null,
                      prefixIcon: Padding(
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          child:  Image.asset('assets/images/SRA.jpeg')
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                     //bool tarfeeh = false;
                    // bool foateer = false;
                    // bool mostlzamat = false;
                    // bool moasalat = false;


                    _selectedCategoryId == 'Basic Supplies'?
                    mostlzamat == true?
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'تم اختيار حد أعلى للصرف لهذا التصنيف سابقا',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),
                          enabled: false,
                        ),

                      ],
                    ) :
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'في حال تم اختيار تصنيف اساسي مسبقا يرجى عدم اضافة حد اعلى مره اخرى!!',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),                        ),
                      ],
                    ):
                    _selectedCategoryId == 'Entertainment'?
                    tarfeeh == true?
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'تم اختيار حد أعلى للصرف لهذا التصنيف سابقا',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),                          enabled: false,
                        ),

                      ],
                    ) :
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'في حال تم اختيار تصنيف اساسي مسبقا يرجى عدم اضافة حد اعلى مره اخرى!!',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),                        ),
                      ],
                    ):
                    _selectedCategoryId == 'Bills'?
                    foateer == true?
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'تم اختيار حد أعلى للصرف لهذا التصنيف سابقا',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),                          enabled: false,
                        ),

                      ],
                    ) :
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'في حال تم اختيار تصنيف اساسي مسبقا يرجى عدم اضافة حد اعلى مره اخرى!!',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),                        ),
                      ],
                    ):
                    _selectedCategoryId == 'Transportation'?
                    moasalat == true?
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'تم اختيار حد أعلى للصرف لهذا التصنيف سابقا',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),                          enabled: false,
                        ),

                      ],
                    ) :
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'في حال تم اختيار تصنيف اساسي مسبقا يرجى عدم اضافة حد اعلى مره اخرى!!',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),                        ),
                      ],
                    ):
                    Column(
                      children: [
                        Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: AppText(text: 'في حال تم اختيار تصنيف اساسي مسبقا يرجى عدم اضافة حد اعلى مره اخرى!!',fontSize: 12,textAlign: TextAlign.start,)),
                        SizedBox(
                          height: 10.h,
                        ),
                        AppTextField(
                          controller: HightcostTextController,
                          hintText: 'حد أعلى للصرف (رقم)',
                          keyboardType: TextInputType.number,
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(vertical: 18.h),
                              child:  Image.asset('assets/images/SRA.jpeg')
                          ),                        ),
                      ],
                    ),








                    SizedBox(
                      height: 40.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: AppElevatedButton(text: 'اضافة', onPressed: () async{
                            setState(() {
                              isLoading =true;
                            });
                            print('rrr $_selectedCategoryId');
                            await _performSave();
                            setState(() {
                              isLoading =false;
                            });
                          },),
                        ),
                        SizedBox(width: 16.w,),
                        Expanded(
                          child: ButtonWithBorder(
                            text: 'حذف البيانات',
                            onPressed: () {
                            setState(() {
                              costTextController.clear();
                              HightcostTextController.clear();
                              newCategoryTextController.clear();
                              nameController.clear();
                              _selectedCategoryId = null;
                            },
                            );
                          },
                            borderColor: Colors.red.withOpacity(0.8),
                            textColor: Colors.red.withOpacity(0.8),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            // Padding(
            //   padding:  EdgeInsets.symmetric(horizontal: 24.w),
            //   child: OutSideButtonWithIcon(
            //     title: ' التصنيفات',
            //     icon: Icon(
            //     Icons.menu_open_outlined,
            //     color: AppColors.primaryColor,
            //     size: 30.sp,
            //   ),
            //     onPressed: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => const CategoriesScreen(),
            //         ));
            //   },
            //   ),
            // )

          ],
        ),
        Visibility(
          visible: isLoading,
            child: const CustomAppLoading())
      ],
    );
  }
  Future<void> _performSave() async{
    if (_checkData()) {
      await _save();
    }
  }
  bool _checkData() {
    if (costTextController.text.isNotEmpty &&
        (newCategoryTextController.text.isNotEmpty||_selectedCategoryId != null)) {
      return true;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ادخل البيانات المطلوبة!')),

      );
      // context.showSnackBar(message: 'ادخل البيانات المطلوبة!', error: true);
      return false;
    }

  }

  Future<void> _save() async {
    try{
      if(_selectedCategoryId != null){
        await FbFirestoreController().createExpense(expense,_selectedCategoryId!);
        await FbFirestoreController().createExpenseAmount(expenseAmount);
      }else{
        await FbFirestoreController().createExpense(expense,'Expense');
        await FbFirestoreController().createExpenseAmount(expenseAmount);
      }
      setState(() {
        costTextController.clear();
        newCategoryTextController.clear();
        _selectedCategoryId = null;
      },
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم الاضافة بنجاح')),

      );
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('عذرا حصل حطأ ما!')),

      );
    }
  }

  ExpenseModel get expense {
    ExpenseModel expense = ExpenseModel();
    expense.expenseAmount = costTextController.text;
    expense.expenseType =_selectedCategoryId==null? newCategoryTextController.text:_selectedCategoryId!;
    expense.ceiling = HightcostTextController.text??'' ;
    expense.userId= SharedPrefController().getValueFor(key: PrefKeys.userId.name);
    expense.userArea= SharedPrefController().getValueFor(key: PrefKeys.userArea.name);
    expense.userName= SharedPrefController().getValueFor(key: PrefKeys.name.name);
    expense.dateNow= DateTime.now().toString().substring(0,10);
    expense.dateNowMonth= DateTime.now().toString().substring(0,7);
    expense.dateNowYear= DateTime.now().toString().substring(0,4);
    return expense;
  }


  ExpenseAmountModel get expenseAmount {
    ExpenseAmountModel expenseAmount = ExpenseAmountModel();
    expenseAmount.userId= SharedPrefController().getValueFor(key: PrefKeys.userId.name);
    expenseAmount.expenseAmount = costTextController.text;
    expenseAmount.expenseName = nameController.text;
    expenseAmount.expenseType =_selectedCategoryId==null? newCategoryTextController.text:_selectedCategoryId!;
    expenseAmount.dateNow= DateTime.now().toString().substring(0,10);
    expenseAmount.dateNowMonth= DateTime.now().toString().substring(0,7);
    expenseAmount.dateNowYear= DateTime.now().toString().substring(0,4);
    return expenseAmount;
  }
}
