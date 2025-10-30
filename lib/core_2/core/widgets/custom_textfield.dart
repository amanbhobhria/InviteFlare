/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/core_2/core/values/app_strings.dart';
import 'package:invite_flare/core_2/core/values/dimens.dart';
import 'package:invite_flare/export.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hint;
  final String? labelText;
  final String? tvHeading;
  final double? height;
  final double? width;
  final double? radius;
  final Color? color;
  final Color? courserColor;
  final validate;
  final hintStyle;
  final EdgeInsets? contentPadding;
  final TextInputType? inputType;
  final TextEditingController? textController;
  final FocusNode? focusNode;
  final Function(String value)? onFieldSubmitted;
  final Function()? onTap;
  final TextInputAction? inputAction;
  final bool? hideBorder;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? maxline;
  final OutlineInputBorder decoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        radius_8,
      ),
      borderSide: const BorderSide(color: Colors.grey, width: 0.3));
  final OutlineInputBorder decoration2 = OutlineInputBorder(
      borderRadius: BorderRadius.circular(
        radius_35,
      ),
      borderSide:
          const BorderSide(color: Colors.grey, style: BorderStyle.solid));
  final int? minLine;
  final int? maxLength;
  final bool readOnly;
  final bool? shadow;
  final bool? obscureText;
  final bool? isOutined;
  final bool? isDecoration2;
  final Function(String value)? onChange;
  final inputFormatter;
  final errorColor;
  final BoxConstraints? boxConstraints;
  final Color? fillColor;
  TextFieldWidget(
      {this.hint,
      this.labelText,
      this.tvHeading,
      this.inputType,
      this.textController,
      this.hintStyle,
      this.courserColor,
      this.validate,
      this.onChange,
      this.radius,
      this.focusNode,
      this.readOnly = false,
      this.shadow,
      this.onFieldSubmitted,
      this.inputAction,
      this.height,
      this.width,
      this.contentPadding,
      this.isOutined = false,
      this.maxline = 1,
      this.minLine = 1,
      this.maxLength,
      this.color,
      this.hideBorder = true,
      this.suffixIcon,
      this.prefixIcon,
      this.obscureText,
      this.onTap,
      this.inputFormatter,
      this.errorColor,
      this.isDecoration2,
      this.boxConstraints,
      this.fillColor});

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        tvHeading == null
            ? const SizedBox()
            : TextView(
                    text: tvHeading ?? '',
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: strFontMediumPoppins))
                .marginOnly(bottom: margin_10),
        TextFormField(
                readOnly: readOnly,
                onTap: onTap,
                obscureText: obscureText ?? false,
                controller: textController,
                focusNode: focusNode,
                keyboardType: inputType,
                maxLength: maxLength,
                // textCapitalization: TextCapitalization.words,
                onChanged: onChange,
                cursorColor: courserColor ?? colorAppGradient1,
                inputFormatters: inputFormatter ?? [],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxLines: maxline,
                minLines: minLine,
                textInputAction: inputAction,
                onFieldSubmitted: onFieldSubmitted,
                validator: validate,
                style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    fontFamily: strFontMediumInter,
                    fontSize: font_14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                decoration: inputDecoration())
            .marginOnly(bottom: height ?? margin_15),
      ],
    );
  }

  inputDecoration() => InputDecoration(
        counterText: "",
        errorMaxLines: 2,
        errorStyle: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
            fontSize: font_10,
            fontWeight: FontWeight.w500,
            color: errorColor ?? Colors.red),
        isDense: true,
        prefixIconConstraints: boxConstraints,
        filled: true,
        contentPadding: contentPadding ??
            EdgeInsets.only(left: margin_10, top: margin_20, bottom: margin_20),
        prefixIcon: prefixIcon,
        suffixIcon: isOutined == true ? null : suffixIcon,
        hintText: hint,
        hintStyle: TextStyle(
            fontFamily: strFontRegularPoppins,
            color: Colors.grey.shade700,
            fontSize: font_14),
        labelText: labelText,
        labelStyle: TextStyle(
            fontFamily: strFontRegularPoppins,
            color: Colors.grey.shade700,
            fontSize: font_14),
        fillColor: fillColor ?? textFieldBgColor,
        border: isDecoration2 == true ? decoration2 : decoration,
        enabledBorder: isDecoration2 == true ? decoration2 : decoration,
        disabledBorder: isDecoration2 == true ? decoration2 : decoration,
        focusedBorder: isDecoration2 == true ? decoration2 : decoration,
      );
}

class DecoratedInputBorder extends InputBorder {
  DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow? shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith(
      {BorderSide? borderSide,
      InputBorder? child,
      BoxShadow? shadow,
      bool? isOutline}) {
    return DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(double t) {
    final scalledChild = child.scale(t);

    return DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t),
    );
  }

  @override
  void paint(Canvas canvas, Rect rect,
      {double? gapStart,
      double gapExtent = 0.0,
      double gapPercentage = 0.0,
      TextDirection? textDirection}) {
    final clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow!.toPaint();
    final Rect bounds =
        rect.shift(shadow!.offset).inflate(shadow!.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(canvas, rect,
        gapStart: gapStart,
        gapExtent: gapExtent,
        gapPercentage: gapPercentage,
        textDirection: textDirection);
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) return false;
    return other is DecoratedInputBorder &&
        other.borderSide == borderSide &&
        other.child == child &&
        other.shadow == shadow;
  }
}
