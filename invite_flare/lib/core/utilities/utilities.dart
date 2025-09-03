import 'dart:ui';

mixin Utilities {
  static Color colorFromHex(String hexColor) {
    // Remove the # if it exists
    final cleanedHex = hexColor.replaceAll('#', '');
    // Convert the cleaned hex string to an integer and add the alpha value if missing
    final colorInt = int.parse(cleanedHex, radix: 16);
    return Color(cleanedHex.length == 6 ? 0xFF000000 | colorInt : colorInt);
  }
}
