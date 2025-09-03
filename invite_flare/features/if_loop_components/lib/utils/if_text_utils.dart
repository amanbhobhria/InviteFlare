part of '../../if_loop_components.dart';

double headingFontSize({
  required IFHeadingSize textSize,
}) {
  switch (textSize) {
    case IFHeadingSize.L:
      return 18;
    case IFHeadingSize.xL:
      return 20;
    case IFHeadingSize.xxL:
      return 22;
    case IFHeadingSize.xxxL:
      return 24;
    case IFHeadingSize.xxxxL:
      return 28;
    case IFHeadingSize.xxxxxL:
      return 32;
    case IFHeadingSize.xxxxxxL:
      return 48;
    case IFHeadingSize.xxxxxxxL:
      return 56;
  }
}

double textFontSize({
  required IFTextSize textSize,
}) {
  switch (textSize) {
    case IFTextSize.xxS:
      return 10;
    case IFTextSize.xS:
      return 12;
    case IFTextSize.S:
      return 14;
    case IFTextSize.M:
      return 16;
    case IFTextSize.L:
      return 18;
  }
}

FontWeight fontWeight({
  required IFTextWeight textWeight,
}) {
  switch (textWeight) {
    case IFTextWeight.light:
      return FontWeight.w300;
    case IFTextWeight.regular:
      return FontWeight.normal;
    case IFTextWeight.semiBold:
      return FontWeight.w600;
    case IFTextWeight.bold:
      return FontWeight.w800;
    default:
      return FontWeight.normal;
  }
}

Color textColors({
  required IFTextColors textColor,
}) {
  switch (textColor) {
    case IFTextColors.BRAND:
      return IFColors.BRAND;
    case IFTextColors.DESCRIPTION:
      return IFColors.DESCRIPTION;
    case IFTextColors.BODY:
      return IFColors.PERAGRAPH;
    case IFTextColors.HEADING:
      return IFColors.HEADING;
    case IFTextColors.HINT:
      return IFColors.HINT;
    case IFTextColors.ERROR:
      return IFColors.ERROR;
    case IFTextColors.WHITE:
      return IFColors.WHITE;
    case IFTextColors.OPACITY_WHITE:
      return IFColors.OPACITY_WHITE;
  }
}
