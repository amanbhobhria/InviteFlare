/*
 *
 *  * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';
import 'package:invite_flare/export.dart';
// import 'package:intl_phone_field/countries.dart';

/*========================Email Validator==============================================*/
class EmailValidator {
  static String? validateEmail(String value) {
    if (value.isEmpty) {
      return keyEmailEmpty.tr;
    } else if (!GetUtils.isEmail(value.trim())) {
      return strInvalidEmail.tr;
    }
    return null;
  }
}
/*================================================== Password Validator ===================================================*/

class PasswordFormValidator {
  static String? validatePassword(String value) {
    var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return strPasswordEmpty.tr;
    } else if (value.length < 8) {
      return strInvalidPassword.tr;
    } else if (!regExp.hasMatch(value)) {
      return strPasswordNotSecure.tr;
    }
    return null;
  }

  static String? validateLoginPassword(String value) {
    if (value.isEmpty) {
      return strPasswordEmpty;
    }
    return null;
  }

  static String? validateNewPassword(String value) {
    var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return strNewPasswordEmpty.tr;
    } else if (value.length < 8) {
      return strInvalidPassword.tr;
    } else if (!regExp.hasMatch(value)) {
      return strNewPasswordNotSecure.tr;
    }
    return null;
  }

  static String? validateChangePassword(String value) {
    var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\£&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      return "New password cannot be empty";
    } else if (value.length < 8) {
      return "Password must contains at least 8 characters.";
    } else if (!regExp.hasMatch(value)) {
      return "Password isn\'t secure. It must contain one or more Capital character, small` character, numeric value and special character";
    }
    return null;
  }

  static String? validateOldPassword({String? value, String? password}) {
    var pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\£&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return "Old Password cannot be empty!";
    } else if (!regExp.hasMatch(value)) {
      return "Old Password isn\'t secure. It must contain one or more Capital character, small character, numeric value and special character";
    }
    return null;
  }

  static String? validateConfirmPasswordMatch({String? value, String? password}) {
    if (value!.isEmpty) {
      return strCPasswordEmpty.tr;
    } else if (value != password) {
      return strPasswordMatch.tr;
    }
    return null;
  }

  static String? validateCurrentPasswordMatch({String? value, String? password}) {
    if (value!.isEmpty) {
      return strPasswordEmpty.tr;
    } else if (value != password) {
      return strCurrentMatch.tr;
    }
    return null;
  }
}

/*================================================== Phone Number Validator ===================================================*/

class PhoneNumberValidate {
  static String? validateMobile(String value) {
    if (value.isEmpty) {
      return strPhoneCannotEmpty.tr;
    } else if (value.length < 8 || value.length > 15) {
      return strPhoneNumberInvalid.tr;
    } else if (isInvalidNumber(value)) {
      return strInvalidContactNumber.tr;
    }
    return null;
  }
}

bool isInvalidNumber(String value) {
  var pattern = r'^[^1-9]+$';
  RegExp regex = RegExp(pattern);
  return (regex.hasMatch(value)) ? true : false;
}

/*===============================Field Checker=================================================*/

class FieldChecker {
  static String? fieldChecker({String? value, message}) {
    if (value == null || value.trim().isEmpty) {
      return "$message ${strCannotBeEmpty.tr}";
    }
    return null;
  }

  static String? countChecker({
    String? value,
    message,
  }) {
    if (value == null || value.toString().trim().isEmpty) {
      return '$message ${strCannotBeEmpty.tr}';
    } else if (value.toString().trim().startsWith('0')) {
      return '$message ${strInvalid.tr}';
    }
    return null;
  }
}

/*===============================Field Checker=================================================*/

class AgeChecker {
  static String? ageChecker({String? value, message}) {
    if (value == null || value.toString().trim().isEmpty) {
      return "$message ${strCannotBeEmpty.tr}";
    } else if (value.toString().trim().startsWith('0')) {
      return '$message cannot start with 0';
    }
    return null;
  }
}
