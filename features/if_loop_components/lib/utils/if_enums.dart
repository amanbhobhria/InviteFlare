part of '../if_loop_components.dart';

enum IFHeadingSize {
  /// Size: 18px [H3]
  L,

  /// Size: 20px [H2]
  xL,

  /// Size: 22px [H1]
  xxL,

  /// Size: 24px [H0 not available into Figma]
  xxxL,

  /// Size: 28px [H0 not available into Figma]
  xxxxL,

  /// Size: 32px [H0 not available into Figma]
  xxxxxL,

  /// Size: 48px [H0 not available into Figma]
  xxxxxxL,

  /// Size: 56px [H0 not available into Figma]
  xxxxxxxL,
}

enum IFTextSize {
  /// Size: 10px [H7]
  xxS,

  /// Size: 12px [H6]
  xS,

  /// Size: 14px [H5]
  S,

  /// Size: 16px [H4]
  M,

  /// Size: 18px [H3]
  L,
}

enum IFTextColors {
  BRAND,
  HEADING,
  BODY,
  DESCRIPTION,
  HINT,
  ERROR,
  WHITE,
  OPACITY_WHITE,
}

enum IFTextWeight {
  /// Weight: w400
  light,

  /// Weight: w500
  regular,

  /// Weight: w600
  semiBold,

  /// Weight: w800
  bold,
}

enum IFSpaces {
  /// space: 8px
  xxxS,

  /// space: 10px
  xxS,

  /// space: 12px
  xS,

  /// space: 14px
  S,

  /// space: 16px
  M,

  /// space: 18px
  L,

  /// space: 20px
  xL,

  /// space: 24px
  xxL,

  /// space: 38px
  xxxL,

  /// space: 32px
  xxxxL,

  /// space: 48px
  xxxxxL,

  /// space: 56px
  xxxxxxL,
}

enum IFSpaceDirection { VERTICAL, HORIZONTAL }

enum IFBorderStroke {
  /// BorderStroke: None
  none,

  /// BorderStroke: 0.5px
  thin,

  /// BorderStroke: 1.5px
  mid,

  /// BorderStroke: 3.5px
  thick,
}

enum IFBorderRadius {
  /// BorderRadius: None
  none,

  /// BorderRadius: 8px
  small,

  /// BorderRadius: 14px
  medium,

  /// BorderRadius: 15px
  large,
}

enum IFElevations {
  /// Elevation: None
  none,

  /// Elevation: 1.5px
  defaults,

  /// Elevation: 2.5px
  medium,

  /// Elevation: 3.5px
  large,
}

enum IFButtonType {
  PRIMARY,
  SECONDARY,
  GOOGLE,
  FACEBOOK,
}

enum IFButtonStyle {
  DEFAULT,
  OUTLINE,
  TEXT,
}

enum IFButtonSize {
  MIN,
  DEFAULT,
}

enum IFSurfaces {
  white,
  black,
  grey,
}

enum TextFieldType {
  EMAIL,
  PASSWORD,
  PHONE,
  TEXT,
  OTHERS,
  INTEGER,
}

enum SocialMediaType {
  FACEBOOK,
  GOOGLE,
}
