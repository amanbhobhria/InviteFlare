import 'package:auto_route/auto_route.dart';
import 'package:invite_flare/core/core.dart';

extension ScreenSize on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
  StackRouter get router => AutoRouter.of(this);
}

extension TextValidatorRegEx on String {
  /// Validates if the string is a valid email address.
  bool get isValidEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  String get emailValidationMessage =>
      Validator.getEmailValidationMessage(this);

  /// Validates if the string meets strong password criteria.
  bool get isValidPassword {
    final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    return passwordRegex.hasMatch(this);
  }

  String? get passwordValidationMessage => Validator.passwordValidate(this);

  String get nameValidationMessage => Validator.getNameValidationMessage(this);

  String otherValidationMessage(String label) =>
      Validator.getOtherValidationMessage(this, label);

  String integerValidationMessage(String label) =>
      Validator.getIntegerValidationMessage(this, label);
}
