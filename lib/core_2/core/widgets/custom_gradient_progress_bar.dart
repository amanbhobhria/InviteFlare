library gradient_progress_bar;

import 'package:flutter/material.dart';

class CustomGradientProgressIndicator extends StatefulWidget {
  final List<Color> colors;

  final double value;

  const CustomGradientProgressIndicator(this.colors, this.value, {Key? key}) : super(key: key);

  @override
  _GradientProgressIndicatorState createState() => _GradientProgressIndicatorState();
}

class _GradientProgressIndicatorState extends State<CustomGradientProgressIndicator> {
  double _value = 0.0;

  @override
  void didUpdateWidget(CustomGradientProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final widthToApply = availableWidth * _value;

        return Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffFFC56F).withOpacity(0.3),
            borderRadius: const BorderRadius.all(Radius.circular(50.0)),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(seconds: 3),
                width: widthToApply,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: _GradientProgressInternal(
                    widget.colors,
                    _value,
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _GradientProgressInternal extends StatelessWidget {
  static const double _kLinearProgressIndicatorHeight = 10.0;
  final List<Color> colors;
  final double value;

  const _GradientProgressInternal(this.colors, this.value);

  @override
  Widget build(BuildContext context) {
    int colorsCount = (colors.length * value).toInt();
    final colorsToApply = colors.sublist(0, colorsCount);
    if (colorsToApply.isEmpty) {
      return Container();
    }
    if (colorsToApply.length < 2) colorsToApply.add(colors[0]);

    return Container(
      constraints: const BoxConstraints.tightFor(
        width: double.infinity,
        height: _kLinearProgressIndicatorHeight,
      ),
      decoration: BoxDecoration(gradient: LinearGradient(colors: colorsToApply)),
    );
  }
}
