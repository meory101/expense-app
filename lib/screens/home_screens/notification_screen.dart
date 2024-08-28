import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tasty_booking/style/app_colors.dart';
import 'package:tasty_booking/utils/helpers.dart';
import 'package:tasty_booking/wdgets/app_text.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() =>
      _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  static const LatLng _ummAlquraUniversityLocation =
      LatLng(25.276987, 55.296249);
  BitmapDescriptor? _customIcon;
  bool onMarkTap = false;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
  }

  Future<void> _loadCustomMarker() async {
    _customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(200.w, 130.h)),
      'assets/images/events2.png',

    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // GoogleMap(
          //   initialCameraPosition:
          //       const CameraPosition(target: _ummAlquraUniversityLocation, zoom: 13),
          //   markers: _customIcon == null
          //       ? {}
          //       : {
          //           Marker(
          //             markerId: const MarkerId('_currentLocation'),
          //             icon: _customIcon!,
          //             position: _ummAlquraUniversityLocation,
          //             onTap: () {
          //               setState(() {
          //                 onMarkTap = true;
          //               });
          //             },
          //           ),
          //         },
          // ),
          // Column(
          //   children: [
          //     const Spacer(),
          //     Container(
          //       width: double.infinity,
          //       height: 227.h,
          //       decoration: BoxDecoration(
          //           gradient: LinearGradient(
          //               colors: [
          //             const Color(0XFF151B33).withOpacity(0.5),
          //             Colors.white.withOpacity(0),
          //           ],
          //               begin: AlignmentDirectional.bottomCenter,
          //               end: AlignmentDirectional.topCenter)),
          //     )
          //   ],
          // ),
          // Visibility(
          //   visible: onMarkTap,
          //   child: Column(
          //     children: [
          //       const Spacer(),
          //       Align(
          //         alignment: AlignmentDirectional.centerStart,
          //         child: InkWell(
          //           onTap: () {
          //             setState(() {
          //               onMarkTap = false;
          //             });
          //           },
          //           child: Container(
          //             padding: EdgeInsets.symmetric(horizontal: 32.w,vertical: 10.h,
          //             ),
          //             margin: EdgeInsets.symmetric(horizontal: 24.w),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(20.r)
          //             ),
          //             child: SvgPicture.asset('assets/images/close2.svg',height: 18.h,width: 18.w,),
          //           ),
          //         ),
          //       ),
          //       SizedBox(height: 12.h,),
          //       Container(
          //         width: double.infinity,
          //         clipBehavior: Clip.antiAlias,
          //         margin: EdgeInsets.symmetric(horizontal: 24.w),
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10.r),
          //             border: Border.all(
          //                 color: const Color(0XFFBDBDBD).withOpacity(0.6),
          //                 width: 0.4.w)),
          //         child: Stack(
          //           children: [
          //             Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 SizedBox(
          //                   height: 125.h,
          //                   width: double.infinity,
          //                   child: Image.asset(
          //                     'assets/images/firoozres.png',
          //                     fit: BoxFit.cover,
          //                   ),
          //                 ),
          //                 Container(
          //                   color: Colors.white,
          //                   child: Column(
          //                     crossAxisAlignment: CrossAxisAlignment.start,
          //                     children: [
          //                       SizedBox(
          //                         height: 10.h,
          //                       ),
          //                       Padding(
          //                         padding: EdgeInsets.symmetric(horizontal: 16.w),
          //                         child: Column(
          //                           crossAxisAlignment: CrossAxisAlignment.start,
          //                           children: [
          //                             const AppText(
          //                               text: 'مطعم فيروز مطعم لبناني',
          //                               fontSize: 18,
          //                               fontWeight: FontWeight.bold,
          //                             ),
          //                             SizedBox(
          //                               height: 18.h,
          //                             ),
          //                             Row(
          //                               children: [
          //                                 Column(
          //                                   crossAxisAlignment:
          //                                       CrossAxisAlignment.start,
          //                                   children: [
          //                                     Row(
          //                                       children: [
          //                                         SvgPicture.asset(
          //                                           'assets/images/openNow.svg',
          //                                           height: 20.h,
          //                                           width: 20.w,
          //                                         ),
          //                                         SizedBox(
          //                                           width: 8.w,
          //                                         ),
          //                                         AppText(
          //                                           text:
          //                                               context.localizations.open_now,
          //                                           fontSize: 10,
          //                                           color: AppColors.primaryColor,
          //                                         ),
          //                                         const AppText(
          //                                           text: ':',
          //                                           fontSize: 10,
          //                                           color: Color(0XFFBDBDBD),
          //                                         ),
          //                                         const AppText(
          //                                           text: '2:00',
          //                                           fontSize: 10,
          //                                           color: AppColors.primaryColor,
          //                                         ),
          //                                         AppText(
          //                                           text:
          //                                               '${context.localizations.evening} - ',
          //                                           fontSize: 10,
          //                                           color: const Color(0XFFBDBDBD),
          //                                         ),
          //                                         const AppText(
          //                                           text: '02:00',
          //                                           fontSize: 10,
          //                                           color: AppColors.primaryColor,
          //                                         ),
          //                                         AppText(
          //                                           text: context.localizations.morning,
          //                                           fontSize: 10,
          //                                           color: const Color(0XFFBDBDBD),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                     SizedBox(
          //                                       height: 10.h,
          //                                     ),
          //                                     Row(
          //                                       children: [
          //                                         SvgPicture.asset(
          //                                           'assets/images/location3.svg',
          //                                           height: 20.h,
          //                                           width: 20.w,
          //                                         ),
          //                                         SizedBox(
          //                                           width: 8.w,
          //                                         ),
          //                                         const AppText(
          //                                           text:
          //                                               'مدينة دبي منطقة الحي الرابع..',
          //                                           fontSize: 10,
          //                                           color: AppColors.primaryColor,
          //                                         ),
          //                                       ],
          //                                     ),
          //                                   ],
          //                                 ),
          //                                 const Spacer(),
          //                                 Container(
          //                                   padding: EdgeInsets.symmetric(
          //                                       horizontal: 28.5.w, vertical: 13.h),
          //                                   decoration: BoxDecoration(
          //                                       borderRadius:
          //                                           BorderRadius.circular(16.r),
          //                                       color: AppColors.primaryColor),
          //                                   child: AppText(
          //                                     text: context.localizations.book_table,
          //                                     color: Colors.white,
          //                                     fontSize: 14,
          //                                     fontWeight: FontWeight.w500,
          //                                   ),
          //                                 )
          //                               ],
          //                             ),
          //                             SizedBox(
          //                               height: 21.h,
          //                             ),
          //                           ],
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 )
          //               ],
          //             ),
          //             PositionedDirectional(
          //                 top: 18.h,
          //                 end: 18.w,
          //                 child: SvgPicture.asset(
          //                   'assets/images/loveOutLine.svg',
          //                   height: 24.h,
          //                   width: 24.w,
          //                 ))
          //           ],
          //         ),
          //       ),
          //       SizedBox(height: 18.h,)
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
