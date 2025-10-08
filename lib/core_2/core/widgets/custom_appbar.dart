/*
 *
 *  * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 *  * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 *  * All Rights Reserved.
 *  * Proprietary and confidential :  All information contained herein is, and remains
 *  * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 *  * Unauthorized copying of this file, via any medium is strictly prohibited.
 *
 */

import 'package:invite_flare/core_2/core/values/app_assets.dart';
import 'package:invite_flare/core_2/core/values/app_strings.dart';
import 'package:invite_flare/core_2/core/values/dimens.dart';

import '../../../export.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarTitleText;
  final actionWidget;
  final bottomPadding;
  final topPadding;
  final Color? bgColor;
  final appBarTitleWidget;
  final leadingIcon;
  final bool? isDrawerIcon;
  final bool? isBackIcon;
  final bool? centerTitle;
  final Function? onTap;

  CustomAppBar({
    Key? key,
    this.appBarTitleText,
    this.onTap,
    this.actionWidget,
    this.bottomPadding,
    this.topPadding,
    this.isDrawerIcon = false,
    this.appBarTitleWidget,
    this.leadingIcon,
    this.isBackIcon = true,
    this.centerTitle = false,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      bottomOpacity: 0.0,
      leading: isBackIcon!
          ? InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ))
          : Container(),
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      title: appBarTitleWidget ??
          (appBarTitleText != "" || appBarTitleText != null
              ? TextView(
                  text: appBarTitleText ?? "",
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                      fontFamily: strFontSemiBoldPoppins,
                      fontSize: font_17,
                      fontWeight: FontWeight.w500),
                )
              : SizedBox(
                  height: 0,
                  width: 0,
                )),
      shadowColor: Colors.transparent,
      backgroundColor: bgColor ?? Colors.white,
      actions: actionWidget ?? [],
    );
  }

  _backIcon() {
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        child: leadingIcon ??
            AssetImageWidget(
              imageUrl: (isDrawerIcon == true ? 'iconMenu' : iconBack),
              imageWidth: isDrawerIcon == true ? height_65 : height_15,
              imageHeight: isDrawerIcon == true ? height_65 : height_15,
            ).paddingOnly(
              top: topPadding ?? margin_15,
              left: margin_15,
              bottom:
                  isDrawerIcon == false ? bottomPadding ?? margin_2 : margin_2,
            ),
        onTap: () {
          if (onTap == null) {
            Get.back(result: true);
          } else {
            onTap!();
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height_50);
}
