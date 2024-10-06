import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasty_booking/style/app_colors.dart';


class BaseTextField extends StatelessWidget {
  final TextStyle? style;
  final TextInputType type;
  final bool? focus;
  final AutovalidateMode? autoValidateMode;
  final TextEditingController? controller;
  final Color? cursorColor;
  final FieldTypes fieldTypes;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final Function(String)? onChanged;
  final Function(String? value) validate;
  final void Function()? onSubmit;
  final int? maxLines;
  final void Function(String)? onFieldSubmitted;
  final Widget? label;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? enabledColor;
  final Color? focusedColor;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? margin;
  final Color? fillColor;
  final Color? color;
  final double? radius;
  final String? errorText;

  const BaseTextField(
      {Key? key,
        this.style,
        required this.type,
        this.focus,
        this.autoValidateMode,
        required this.controller,
        this.cursorColor,
        required this.fieldTypes,
        this.focusNode,
        this.inputFormatters,
        this.maxLength,
        this.maxLengthEnforcement,
        this.onChanged,
        required this.validate,
        this.onSubmit,
        this.maxLines,
        this.onFieldSubmitted,
        this.label,
        required this.hint,
        this.prefixIcon,
        this.suffixIcon,
        this.enabledColor,
        this.focusedColor,
        this.contentPadding,
        this.fillColor,
        this.color,
        this.radius,
        this.errorText,
        this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
      margin ?? const EdgeInsets.symmetric(vertical: 10,),
      child: Visibility(
        visible: fieldTypes == FieldTypes.clickable,
        replacement: _buildFormField(),
        child: _buildClickableView(),
      ),
    );
  }

  Widget _buildClickableView() {
    return AbsorbPointer(
      absorbing: true,
      child: _buildFormField(),
    );
  }

  Widget _buildFormField() {
    return TextFormField(
      style: style,
      autocorrect: true,
      autofillHints: getAutoFillHints(type),
      autofocus: focus ?? true,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      controller: controller,
      cursorColor: cursorColor ?? AppColors.primaryColor,
      cursorHeight: 20,
      cursorRadius: const Radius.circular(2),
      cursorWidth: 2,
      enabled: fieldTypes != FieldTypes.disabled,
      enableIMEPersonalizedLearning: true,
      enableInteractiveSelection: true,
      enableSuggestions: true,
      focusNode: focusNode,
      inputFormatters: inputFormatters ??
          [if (maxLength != null) LengthLimitingTextInputFormatter(maxLength)],
      keyboardAppearance: Brightness.dark,
      keyboardType: type,
      maxLength: maxLength,
      maxLengthEnforcement:
      maxLengthEnforcement ?? MaxLengthEnforcement.enforced,
      maxLines: fieldTypes == FieldTypes.password ? 1 : maxLines,
      minLines: maxLength ?? 1,
      obscureText: fieldTypes == FieldTypes.password,
      obscuringCharacter: "*",
      onChanged: onChanged,
      onEditingComplete: onSubmit,
      onFieldSubmitted: onFieldSubmitted,
      readOnly: fieldTypes == FieldTypes.readOnly,
      validator: (value) => validate(value),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        hintText: hint,
        counterText: '',
        errorText: errorText,
        errorMaxLines: 1,
        errorStyle:  TextStyle(fontSize: 0.0.sp),
        hintStyle: TextStyle(
          fontSize: 16.sp, color:  AppColors.grayColor,
          fontWeight: FontWeight.w400,
          fontFamily: 'DINNextLTArabic_Light',
        ),
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(width: 1.w, color:  Colors.red),
        ),
        focusedErrorBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.r),
          borderSide: BorderSide(width: 1.w, color:  Colors.red),
        ),

      ),
    );
  }

  List<String> getAutoFillHints(TextInputType inputType) {
    if (inputType == TextInputType.emailAddress) {
      return [AutofillHints.email];
    } else if (inputType == TextInputType.datetime) {
      return [AutofillHints.birthday];
    } else if (inputType == TextInputType.phone) {
      return [AutofillHints.telephoneNumber];
    } else if (inputType == TextInputType.url) {
      return [AutofillHints.url];
    }
    return [AutofillHints.name, AutofillHints.username];
  }
}

enum FieldTypes { clickable, normal, chat, readOnly, password, rich, disabled }