part of '../if_loop_components.dart';

class IFTextStyles {
  IFTextStyles._();

  static IFTextStyles get style => IFTextStyles._();

  TextStyle headingStyle({
    required IFHeadingSize textSize,
    required IFTextWeight textWeight,
    required IFTextColors textStyle,
  }) {
    return TextStyle(
      fontSize: headingFontSize(
        textSize: textSize,
      ),
      fontFamily: 'Poppins',
      letterSpacing: 0,
      fontWeight: fontWeight(
        textWeight: textWeight,
      ),
      color: textColors(
        textColor: textStyle,
      ),
    );
  }

  TextStyle textStyle({
    required IFTextSize textSize,
    required IFTextWeight textWeight,
    required IFTextColors textStyle,
    TextOverflow? textOverflow,
  }) {
    return TextStyle(
      fontSize: textFontSize(
        textSize: textSize,
      ),
      overflow: textOverflow,
      fontFamily: 'Poppins',
      fontWeight: fontWeight(
        textWeight: textWeight,
      ),
      color: textColors(
        textColor: textStyle,
      ),
    );
  }
}
