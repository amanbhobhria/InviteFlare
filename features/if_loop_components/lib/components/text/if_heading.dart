part of '../../if_loop_components.dart';

class IFHeading extends StatelessWidget {
  final String text;
  final IFHeadingSize headingSize;
  final IFTextWeight textWeight;
  final IFTextColors textColor;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;

  const IFHeading({
    super.key,
    required this.text,
    this.headingSize = IFHeadingSize.L,
    this.textWeight = IFTextWeight.semiBold,
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
      style: IFTextStyles.style.headingStyle(
        textSize: headingSize,
        textWeight: textWeight,
        textStyle: textColor,
      ),
    );
  }
}
