part of '../../if_loop_components.dart';

class IFText extends StatelessWidget {
  final String text;
  final IFTextSize textSize;
  final IFTextWeight textWeight;
  final IFTextColors textColor;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;

  const IFText({
    super.key,
    required this.text,
    this.textSize = IFTextSize.M,
    this.textWeight = IFTextWeight.regular,
    this.textColor = IFTextColors.HEADING,
    this.textAlign,
    this.textOverflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
      style: IFTextStyles.style.textStyle(
        textSize: textSize,
        textWeight: textWeight,
        textStyle: textColor,
      ),
    );
  }
}
