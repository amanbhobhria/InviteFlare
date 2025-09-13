import 'dart:math';
import 'package:invite_flare/core_2/core/values/text_styles.dart';

import '../../../export.dart';
import '../translations/local_keys.dart';
import '../values/app_colors.dart';
import '../widgets/text_view.dart';

int backPressCounter = 0;

SizedBox emptySizeBox() => const SizedBox(
      height: 0.0,
      width: 0.0,
    );

Center resultNotFound({message}) => Center(
      child: Text(
        message ?? keyNoResultFound.tr,
        style: textStyleBody2(),
      ),
    );

loadingWidget() => Center(
        child: CircularProgressIndicator(
      color: colorAppGradient1,
      backgroundColor: Colors.white,
    ));

Widget noDataToShow({inputText, color = Colors.black}) {
  return Center(child: TextView(text: inputText ?? 'No Data Found', textStyle: textStyleBody1()));
}

getRandomString() {
  var rdmNumber = Random();
  return rdmNumber.nextInt(5);
}

switchEmotionText(i) {
  switch (i) {
    case 0:
      return "Happiness and delight";
    case 1:
      return "Satisfaction and peaceful";
    case 2:
      return "I'm feeling neutral";
    case 3:
      return "Grief or sorrow";
    case 4:
      return "Frustration or fury";
    case 5:
      return "Anxiety or depression";
  }
}

switchBannerText(number) {
  switch (number) {
    case 1:
      return stringReadyToRushItToday.tr;
    case 2:
      return strLetsMakeItAmazingToday.tr;
    case 3:
      return strLetsHitThoseGoal.tr;
    case 4:
      return strGoodToSeeYou.tr;
    default:
      return stringWelcome.tr;
  }
}

switchCaseWidget(index) {
  switch (index) {
    case 0:
      return "Health and Beauty";
    case 1:
      return "Wellness Equipment";
    case 2:
      return "Home";
    case 3:
      return "Vitamins and Nutrition";
    case 4:
      return "Meal Delivery";
  }
}

switchSizeWidget(size) {
  switch (size) {
    case "Small":
      return "S";
    case "Med":
      return "M";
    case "Large":
      return "L";
    case "XL":
      return "XL";
    default:
      return size;
  }
}
