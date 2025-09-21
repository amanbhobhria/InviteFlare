import 'package:flutter/widgets.dart';

import '../../../export.dart';

class TextView extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final TextAlign textAlign;
  final int maxLine;

  const TextView({Key? key, required this.text, required this.textStyle, this.maxLine = 15, this.textAlign = TextAlign.center}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
class LinearGradientText extends StatelessWidget {
  final String text;

  final TextStyle style;
  final TextAlign? align;
  final Gradient gradient;

  LinearGradientText({required this.text, required this.style, required this.gradient, this.align});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(bounds),
      child: Text(
        text,
        textAlign: align != null ? align : TextAlign.start,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}
