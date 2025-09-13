

// ignore_for_file: prefer_expression_function_bodies

import 'package:get/get_core/src/get_main.dart';
import 'package:invite_flare/core/base/base.dart';

import 'package:invite_flare/core_2/core/translations/local_keys.dart';
import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/core_2/core/values/app_strings.dart';
import 'package:invite_flare/core_2/core/values/dimens.dart';
import 'package:invite_flare/core_2/core/values/text_styles.dart';
import 'package:invite_flare/core_2/core/widgets/asset_image.dart';
import 'package:invite_flare/core_2/core/widgets/text_view.dart';
import 'package:invite_flare/core_2/routes/app_routes.dart';
import 'package:invite_flare/export.dart';

class MaterialButtonWidget extends StatelessWidget {
  final String? buttonText;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonRadius;
  final double? minWidth;
  final double? minHeight;
  final double? padding;
  final onPressed;
  final decoration;
  final elevation;
  final padding2;
  final bool? isSocial;
  final double? fontsize;
  final Widget? iconWidget;

  const MaterialButtonWidget({
    Key? key,
    this.buttonText = "",
    this.buttonColor,
    this.textColor,
    this.buttonRadius = 10,
    this.decoration,
    this.isSocial = false,
    this.onPressed,
    this.elevation,
    this.iconWidget,
    this.fontsize,
    this.minWidth,
    this.minHeight,
    this.padding,
    this.padding2,
  }) : super(key: key);

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return MaterialButton(
        height: minHeight,
        splashColor: Colors.transparent,
        minWidth: minWidth ?? Get.width,
        color: buttonColor ?? appColor,
        elevation: elevation ?? radius_4,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(buttonRadius!)),
        onPressed: onPressed,
        padding: padding2 ??
            EdgeInsets.symmetric(
                vertical: padding ?? margin_15,
                horizontal: padding ?? margin_15),
        child: TextView(
            text: buttonText!,
            textStyle: textStyleButton().copyWith(
                color: textColor ?? Colors.white,
                fontSize: fontsize,
                fontFamily: strFontMediumPoppins)));
  }
}

class GradientButton extends StatelessWidget {
  final Widget? child;
  final Gradient? gradient;
  final bool? isHeight;
  final double width;
  final buttonText;
  final textColor;
  final borderColor;
  final fontSize;
  final fontWeight;
  final color;
  final raduis;
  final double? height;
  final String? leadingAssets;
  final String? icons;
  final Function()? onPressed;
  final bool isShadow;

  const GradientButton({
    Key? key,
    this.child,
    this.gradient,
    this.textColor,
    this.borderColor,
    this.raduis,
    this.color,
    this.buttonText,
    this.fontSize,
    this.leadingAssets,
    this.fontWeight,
    this.width = double.infinity,
    this.height,
    this.isHeight = false,
    this.onPressed,
    this.icons,
    this.isShadow = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height != null ? height : height_45,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(raduis ?? margin_30),
          gradient: gradient ??
              LinearGradient(colors: [colorAppGradient1, colorAppGradient2]),
          boxShadow: []),
      child: InkWell(
          onTap: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              leadingAssets != null
                  ? AssetImageWidget(
                      imageHeight: fontSize,
                      imageUrl: leadingAssets!,
                    )
                  : SizedBox(),
              Center(
                  child: TextView(
                      text: buttonText!,
                      textStyle: TextStyle(
                          fontFamily: strFontMediumPoppins,
                          color: textColor ?? Colors.white,
                          fontSize: fontSize,
                          fontWeight: fontWeight))),
              SizedBox(
                  // width: width_12,
                  ),
              icons != null
                  ? AssetImageWidget(
                      imageHeight: height_25,
                      imageUrl: icons!,
                    )
                  : SizedBox(),
            ],
          )),
    );
  }
}

class TiredButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.tiredScreen);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width_18, vertical: height_5),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(radius_10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5.0,
            ),
          ],
        ),
        child: Text(
          stringTiredButtonText.tr,
          style: TextStyle(fontSize: font_13, fontFamily: strFontMediumPoppins),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
