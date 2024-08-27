import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
import 'package:tasty_booking/wdgets/app_text_field.dart';

class ReservationsScreen extends StatefulWidget {
  const ReservationsScreen({super.key});

  @override
  State<ReservationsScreen> createState() => _ReservationsScreenState();
}

class _ReservationsScreenState extends State<ReservationsScreen> {
  late TextEditingController _cobonController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cobonController = TextEditingController();
  }

  @override
  void dispose() {
    _cobonController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 24.w,vertical: 60.h),
        itemBuilder: (context, index) {
      return  Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color:Color(0XFFBDBDBD).withOpacity(0.6),width: 0.4.w)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row(
            //   children: [
            //     AppText(text: 'الحجز رقم '),
            //     Spacer(),
            //     AppText(text: '30320601#',color: Color(0XFFBDBDBD),fontSize: 14,),
            //   ],
            // ),
            // Row(
            //   children: [
            //     Container(
            //       padding:EdgeInsetsDirectional.only(start: 16.w,end: 12.w,top: 12.h,bottom: 12.h),
            //       child: Row(
            //         children: [
            //           SvgPicture.asset('assets/images/clockIcon.svg',height: 22.h,width: 22.w,),
            //           SizedBox(width: 9.5.w,),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               AppText(text: '${context.localizations.booking_date}( اليوم )',color: const Color(0XFF9E9E9E),fontSize: 10,),
            //               const AppText(text: '29 Febuary 2024',fontSize: 14,),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //     SizedBox(width: 8.w,),
            //     Container(
            //       padding:EdgeInsetsDirectional.only(start: 16.w,end: 12.w,top: 12.h,bottom: 12.h),
            //       child: Row(
            //         children: [
            //           SvgPicture.asset('assets/images/alarmClock.svg',height: 24.h,width: 24.w,),
            //           SizedBox(width: 9.5.w,),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               AppText(text: '${context.localizations.booking_date}( التوقيب )',color: const Color(0XFF9E9E9E),fontSize: 10,),
            //               const AppText(text: '29 Febuary 2024',fontSize: 14,),
            //             ],
            //           )
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            // Divider(
            //   height: 32.h,
            //   color: Color(0XFFE5E7EB),
            // ),
            // Container(
            //   clipBehavior: Clip.antiAlias,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10.r),
            //       border: Border.all(color:Color(0XFFBDBDBD).withOpacity(0.6),width: 0.4.w)
            //   ),
            //   child: Row(
            //     children: [
            //       SizedBox(
            //         height: 115.h,
            //         width: 129.w,
            //         child: Image.asset('assets/images/foodImage.png',fit: BoxFit.cover,),
            //       ),
            //       SizedBox(width: 16.w,),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           AppText(text: 'مطعم فيروز مطعم لبناني',fontSize: 12,fontWeight: FontWeight.bold,),
            //           SizedBox(height: 8.h,),
            //           Row(
            //             children: [
            //               SvgPicture.asset('assets/images/location3.svg',height: 20.h,width: 20.w,),
            //               SizedBox(width: 8.w,),
            //               const AppText(text: 'مدينة دبي منطقة الحي الرابع..',fontSize: 10,color: Color(0XFF6B7280),),
            //
            //             ],
            //           ),
            //           SizedBox(height: 11.h,),
            //           Row(
            //             children: [
            //               SvgPicture.asset('assets/images/openNow.svg',height: 20.h,width: 20.w,),
            //               SizedBox(width: 8.w,),
            //               AppText(text: context.localizations.open_now,fontSize: 10,color: AppColors.primaryColor,),
            //               const AppText(text: ':',fontSize: 10,color: Color(0XFFBDBDBD),),
            //               const AppText(text: '2:00',fontSize: 10,color: AppColors.primaryColor,),
            //               AppText(text: '${context.localizations.evening} - ',fontSize: 10,color: const Color(0XFFBDBDBD),),
            //               const AppText(text: '02:00',fontSize: 10,color: AppColors.primaryColor,),
            //               AppText(text: context.localizations.morning,fontSize: 10,color: const Color(0XFFBDBDBD),),
            //             ],
            //           ),
            //         ],
            //       )
            //     ],
            //   ),
            // ),
            // SizedBox(height: 16.h,),
            // Center(
            //   child: AppText(text: 'اضغط لعرض الموقع على الخريطة',fontSize: 10,color: AppColors.primaryColor,),
            // ),
            // SizedBox(height: 16.h,),
            // AppText(text:'الفاتورة',fontSize: 16,fontWeight: FontWeight.w600,),
            // SizedBox(height: 16.h,),
            // Column(
            //   children: [
            //     Row(
            //       children: [
            //         AppText(text: context.localizations.reservation_fees,fontSize: 10,color: const Color(0XFF757575),),
            //         const Spacer(),
            //         const AppText(text: '\$124',fontSize: 12),
            //       ],
            //     ),
            //     SizedBox(height: 10.h,),
            //     Row(
            //       children: [
            //         AppText(text: context.localizations.vat,fontSize: 10,color: const Color(0XFF757575),),
            //         const Spacer(),
            //         const AppText(text: '\$1',fontSize: 12),
            //       ],
            //     ),
            //     SizedBox(height: 10.h,),
            //     Row(
            //       children: [
            //         AppText(text: context.localizations.discount_coupon,fontSize: 10,color: const Color(0XFF757575),),
            //         const Spacer(),
            //         const AppText(text: '(- \$5)',fontSize: 12,color: Colors.red,),
            //       ],
            //     ),
            //     SizedBox(height: 10.h,),
            //     Row(
            //       children: [
            //         AppText(text: context.localizations.total_reservation_cost,fontSize: 10,fontWeight: FontWeight.bold,),
            //         const Spacer(),
            //         const AppText(text: '\$120.00',fontSize: 20,fontWeight: FontWeight.bold,color: AppColors.primaryColor,),
            //       ],
            //     ),
            //   ],
            // ),
            // SizedBox(height: 16.h,),
            // Row(
            //   children: [
            //     SvgPicture.asset('assets/images/checkmark-circle-01.svg',height: 24.h,width: 24.w,),
            //     SizedBox(width: 8.w,),
            //     AppText(text: 'تم الحجز بنجاح والمطعم فى انتظارك فى الموعد المحدد',fontSize: 14,color: AppColors.primaryColor,),
            //   ],
            // )
          ],
        ),
      );
    }, separatorBuilder: (context, index) => SizedBox(height: 19.h,), itemCount: 0);
  }
}
