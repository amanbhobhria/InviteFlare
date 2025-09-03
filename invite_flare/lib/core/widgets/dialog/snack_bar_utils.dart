import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';

mixin SnackBarUtils {
  static void show({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: IFText(
        text: message,
        textColor: IFTextColors.WHITE,
      )),
    );
  }
}
