import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';

class SloganWidget extends StatelessWidget {
  final String heading;
  final String sloganText;

  const SloganWidget({
    super.key,
    required this.heading,
    required this.sloganText,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IFHeading(
              text: heading,
              headingSize: IFHeadingSize.xxL,
              textWeight: IFTextWeight.bold,
            ),
            const SizedBox(height: 8),
            IFText(
              text: sloganText,
              textWeight: IFTextWeight.light,
              textSize: IFTextSize.xS,
            ),
          ],
        ),
      );
}
