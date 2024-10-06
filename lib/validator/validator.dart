import 'package:flutter/material.dart';
import 'package:tasty_booking/utils/helpers.dart';
List<String> appKeyWords = [
  "league",
  "sport",
  "leagueplus",
  "League",
  "Player"
      "academic",
  "academy agent leagueplus",
  "coach",
  "coach leagueplus",
  "agent",
  "agent leagueplus",
  "academy",
  "academy leagueplus",
  "academy agent",
  "academy agent leagueplus",
  "academy coach",
  "academy coach leagueplus",
  "academy agent coach",
  "academy agent coach leagueplus",
  "agent coach",
  "agent coach leagueplus",
];
extension Validator on String {

  String? noValidate() {
    return null;
  }
  //
  String? validateEmpty(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? context.localizations.fillField;
    }
    return null;
  }

  String? _checkAppKeyWords () {
    return appKeyWords.map((e){
      if(contains(e)){
        return e ;
      }else {
        return null ;
      }
    }).toList().firstWhere((element) => element != null, orElse: () => null);

  }

  String? validatePasswordConfirm(BuildContext context,{required String pass, String? message}) {
    if (trim().isEmpty) {
      return message ?? context.localizations.fillField;
    } else if (this != pass) {
      return message ?? context.localizations.confirm_password;
    }
    return null;
  }


  String? validateName(BuildContext context, ) {
    if(_checkAppKeyWords() != null){
      if (trim().isEmpty) {
        return context.localizations.fillField;
      } else if (length < 4 || length > 30) {
        return "it must be more than 4 and less than 30";
      }
      if(_checkAppKeyWords()!.isNotEmpty){
        return "${context.localizations.cant_use_this_word} $this";
      }
    }else {
      if (trim().isEmpty) {
        return context.localizations.fillField;
      } else if (length < 4 || length > 30) {
        return "it must be more than 4 and less than 30";
      }
      return null;
    }
    if (trim().isEmpty) {
      return context.localizations.fillField;
    } else if (length < 4 || length > 30) {
      return "it must be more than 4 and less than 30";
    }
    return null;
  }
  String? validatePhoneSAUDi(BuildContext context,{String? message, required bool isSaudiCode}) {
    if(isSaudiCode){
      if (trim().isEmpty) {
        return message ?? context.localizations.fillField;
      } else if (!RegExp(r'^5\d{8}$').hasMatch(this)) {
        return message ?? context.localizations.phone_validation;
      }else{
        return null;
      }
    }else{
      if (trim().isEmpty) {
        return message ?? context.localizations.fillField;
      } else if (!RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{2}[-\s\.]?[0-9]{4,6}$)').hasMatch(this)) {
        return message ?? context.localizations.phone_validation;
      }else{
        return null;
      }
    }

  }
  String? validateAddress(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? context.localizations.fillField;
    } else if (length < 5 || length > 100) {
      return message ?? context.localizations.validate_name;
    }
    return null;
  }

  String? validatePassword(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? context.localizations.fillField;
    }
    // else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$').hasMatch(this)) {
    //   return message ?? context.localizations.pass_validation;
    // }
    return null;
  }

  String? validateEmail(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? context.localizations.fillField;
    } else if (!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this)) {
      return message ?? context.localizations.mail_validation;
    }
    return null;
  }

  String? validateEmailORNull(BuildContext context, {String? message}) {
    if (trim().isNotEmpty) {
      if (!RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(this)) {
        return message ?? context.localizations.mail_validation;
      }
    }
    return null;
  }

  String? validatePhone(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return message ?? context.localizations.fillField;
    } else if (
    length < 10) {
      return message ?? context.localizations.phone_validation;
    }
    return null;
  }

  String? validatePhoneOrNull(BuildContext context, {String? message}) {
    if (trim().isEmpty) {
      return null;
    } else if (!RegExp(
        r'(^\+[0-9]{2}|^\+[0-9]{2}\(0\)|^\(\+[0-9]{2}\)\(0\)|^00[0-9]{2}|^0)([0-9]{9}$|[0-9\-\s]{10}$)')
        .hasMatch(this) ||
        length < 10) {
      return message ?? context.localizations.phone_validation;
    }
    return null;
  }

}
