import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:tasty_booking/wdgets/app_text.dart';
extension ContextHelper on BuildContext {
  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: AppText(
          text: message,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        backgroundColor: error ? Colors.red.shade700 : Colors.green.shade300,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        duration: const Duration(seconds: 3),
        dismissDirection: DismissDirection.down,
      ),
    );
  }

  AppLocalizations get localizations{
    return AppLocalizations.of(this)!;
  }
}
