import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/features/home/presentation/presentation.dart';

class ExplainerSectionView extends StatelessWidget {
  final String heading;
  final List<Map<String, dynamic>> steps;

  const ExplainerSectionView({
    super.key,
    required this.heading,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IFHeading(
              text: heading,
              textAlign: TextAlign.center,
            ),
            const IFSpace(),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                steps.length,
                (index) => ExplainerSectionTile(
                  isOdd: index % 2 == 0,
                  lottieJson: steps[index]['lottieJson'],
                  colorCode: steps[index]['colorBg'],
                  step: steps[index]['step'],
                  heading: steps[index]['title'],
                  description: steps[index]['subTitle'],
                ),
              ),
            )
          ],
        ),
      );
}
