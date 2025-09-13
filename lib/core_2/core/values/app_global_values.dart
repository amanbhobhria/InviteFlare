

import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/core_2/core/values/dimens.dart';
import 'package:invite_flare/core_2/core/values/text_styles.dart';

import '../../../export.dart';

int defaultItemCount = 10;

// var log = Logger();
GetStorage storage = GetStorage();

final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerState =
    GlobalKey<ScaffoldMessengerState>();

void showInSnackBar({required String message}) {
  scaffoldMessengerState.currentState?.activate();

  scaffoldMessengerState.currentState?.showSnackBar(SnackBar(
    elevation: 2,
    dismissDirection: DismissDirection.horizontal,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(margin_10))),
    backgroundColor: colorAppGradient1,
    behavior: SnackBarBehavior.floating,
    content: TextView(
        textAlign: TextAlign.start,
        maxLine: 5,
        text: message,
        textStyle: textStyleBody2().copyWith(
            fontSize: font_12,
            color: Colors.white,
            fontWeight: FontWeight.w400)),
    duration: const Duration(seconds: 2),
  ));
}
