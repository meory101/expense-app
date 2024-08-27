import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';
import 'package:tasty_booking/wdgets/search_text_fild.dart';
import 'package:tasty_booking/wdgets/section_title.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late TextEditingController _searchEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _searchEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _searchEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: 200.h,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: const BoxDecoration(color: AppColors.primaryColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 62.h,),
                  Row(
                    children: [
                      Container(
                        height: 64.h,
                        width: 64.w,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          // backgroundBlendMode: BlendMode.srcIn
                        ),
                        child:  const Image(
                          image: AssetImage('assets/images/Ellipse.png'),
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: '${context.localizations.hi} محمد خالد 👋 ',
                            fontFamily: 'DINNextLTArabic_bold',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          AppText(
                            text: context.localizations.welcome,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ],
                      ),
                      const Spacer(),
                      /*GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => NotficationList()));
                        },
                        child: Container(
                          height: 60.h,
                          width: 60.h,
                          // padding: EdgeInsets.symmetric(vertical: 18.h),
                          decoration: BoxDecoration(
                              color: const Color(0XFF59C4FF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16.r)),
                          child: Center(
                            child: SizedBox(
                                height: 28.h,
                                width: 28.w,
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: AlignmentDirectional.center,
                                        child: SvgPicture.asset(
                                          'assets/images/notificationIcon.svg',
                                          height: double.infinity.h,
                                          width: double.infinity.w,
                                        )),
                                    Align(
                                      alignment: AlignmentDirectional.bottomStart,
                                      child: Container(
                                        height: 8.h,
                                        width: 8.w,
                                        margin: EdgeInsetsDirectional.only(
                                            bottom: 3.h),
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0XFFFC5555),
                                        ),
                                        // child: Center(child: AppText(text: '3',fontSize: 8.sp,fontWeight: FontWeight.w500,color: Colors.white,textAlign: TextAlign.center,height: 1.2.h,),),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      )*/
                    ],
                  ),
                  SizedBox(height: 16.h,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/locationIcon.svg',height: 16.h,width: 16.w,),
                      SizedBox(width: 2.w,),
                      AppText(text: ' القاهره . مصر الجديده  ..',color: Colors.white,fontSize: 10,)
                    ],
                  ),

                ],
              ),
            ),


          ],
        ),
      ],
    );
  }
}




