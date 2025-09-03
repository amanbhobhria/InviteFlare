import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SystemUiHandler {
  /// Set light theme for status bar and navigation bar
  static void setLightTheme() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness:
            Brightness.dark, // Dark icons for light background
        statusBarBrightness: Brightness.light, // For iOS
        systemNavigationBarColor: Colors.white, // Navigation bar color
        systemNavigationBarIconBrightness:
            Brightness.light, // Dark icons for light nav bar
      ),
    );
  }


  void setDarkTheme() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness:
          Brightness.light, // Light icons for dark background
      statusBarBrightness: Brightness.dark, // For iOS
      systemNavigationBarColor: Colors.black, // Navigation bar color
      systemNavigationBarIconBrightness:
          Brightness.light, // Light icons for dark nav bar
    ));
  }



     /// Custom theme configuration
  void setCustomTheme({
    required Color statusBarColor,
    required Brightness statusBarIconBrightness,
    required Color navigationBarColor,
    required Brightness navigationBarIconBrightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: statusBarIconBrightness,
      statusBarBrightness: statusBarIconBrightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarColor: navigationBarColor,
      systemNavigationBarIconBrightness: navigationBarIconBrightness,
    ));
  }
}
