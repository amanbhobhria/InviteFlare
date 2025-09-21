/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */


import 'package:flutter/cupertino.dart';
import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/core_2/core/values/dimens.dart';
import 'package:invite_flare/core_2/core/values/font_family.dart';
import 'package:invite_flare/export.dart';


// ignore: avoid_classes_with_only_static_members
class ThemeConfig {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryText,
    Color? secondaryText,
    required Color accentColor,
    Color? divider,
    Color? buttonBackground,
    required Color buttonText,
    Color? cardBackground,
    Color? disabled,
    required Color error,
  }) {
    final baseTextTheme = brightness == Brightness.dark ? Typography.blackMountainView : Typography.whiteMountainView;

    return ThemeData(
      brightness: brightness,
      canvasColor: background,
      primaryColorDark: Colors.red,
      primarySwatch: Colors.red,
      cardColor: background,
      dividerColor: divider,
      pageTransitionsTheme: const PageTransitionsTheme(builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      }),
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),

      primaryColor: accentColor,
      colorScheme: ColorScheme.fromSwatch(accentColor: accentColor, brightness: brightness),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colorAppGradient1,
        selectionColor: Colors.orange.shade50,
        selectionHandleColor: colorAppGradient1,
      ),
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(statusBarBrightness: brightness),
        color: Colors.black,
        toolbarTextStyle: TextStyle(
          color: secondaryText,
          fontSize: 18.0.sp,
        ),
        iconTheme: IconThemeData(color: colorAppGradient1, size: height_25),
      ),
      iconTheme: IconThemeData(
        color: colorAppGradient1,
        size: height_25,
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        colorScheme: ColorScheme(
          brightness: brightness,
          primary: Colors.purple,
          primaryContainer: accentColor,
          secondary: accentColor,
          secondaryContainer: accentColor,
          surface: background,
          background: background,
          error: error,
          onPrimary: buttonText,
          onSecondary: buttonText,
          onSurface: buttonText,
          onBackground: buttonText,
          onError: buttonText,
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: brightness,
        primaryColor: accentColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: colorAppGradient1, width: 1.5),
        ),
        errorStyle: TextStyle(color: error),
        labelStyle: TextStyle(
          fontFamily: FontFamily.mazzard,
          fontWeight: FontWeight.w600,
          fontSize: 16.0,
          color: primaryText.withOpacity(0.5),
        ),
      ),
      fontFamily: FontFamily.mazzard,
      unselectedWidgetColor: Colors.grey,
      textTheme: TextTheme(

      ),
    );
  }

  static ThemeData get lightTheme => createTheme(
    brightness: Brightness.light,
    background: Colors.white,
    cardBackground: Colors.white,
    primaryText:Colors.black,
    secondaryText: Colors.white,
    accentColor: colorAppGradient1,
    divider: colorAppGradient1,
    buttonBackground: Colors.black38,
    buttonText: colorAppGradient1,
    disabled: colorAppGradient1,
    error: Colors.red,
  );

  static ThemeData get darkTheme => createTheme(
    brightness: Brightness.dark,
    background: Colors.black,
    cardBackground: colorAppGradient1,
    primaryText: Colors.white,
    secondaryText: Colors.black,
    accentColor: Colors.transparent,
    divider: Colors.black45,
    buttonBackground: Colors.white,
    buttonText: colorAppGradient1,
    disabled: colorAppGradient1,
    error: Colors.red,
  );
}