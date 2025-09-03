import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:lottie/lottie.dart';

class ExplainerSectionTile extends StatelessWidget {
  final bool isOdd;
  final String lottieJson;
  final int colorCode;
  final String step;
  final String heading;
  final String description;

  const ExplainerSectionTile({
    super.key,
    required this.isOdd,
    required this.lottieJson,
    required this.colorCode,
    required this.step,
    required this.heading,
    required this.description,
  });

  @override
  Widget build(BuildContext context) => IFCard(
      borderRadius: BorderRadius.circular(15),
      surfaceColor: IFColors.SURFACE_COLOR,
      child: isOdd ? _isOddView() : _isEvenView());

  Widget _isOddView() => Row(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              color: Color(colorCode),
            ),
            child: Lottie.asset(
              lottieJson,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IFText(
                    text: step,
                    textSize: IFTextSize.S,
                    textWeight: IFTextWeight.semiBold,
                    textColor: IFTextColors.BRAND,
                  ),
                  const IFSpace(
                    space: IFSpaces.xxxS,
                  ),
                  IFText(
                    text: heading,
                    textSize: IFTextSize.S,
                    textWeight: IFTextWeight.semiBold,
                  ),
                  const IFSpace(
                    space: IFSpaces.xxxS,
                  ),
                  IFText(
                    text: description,
                    textSize: IFTextSize.xS,
                    textColor: IFTextColors.DESCRIPTION,
                  ),
                ],
              ),
            ),
          )
        ],
      );

  Widget _isEvenView() => Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IFText(
                    text: step,
                    textSize: IFTextSize.S,
                    textWeight: IFTextWeight.semiBold,
                    textColor: IFTextColors.BRAND,
                  ),
                  const IFSpace(
                    space: IFSpaces.xxxS,
                  ),
                  IFText(
                    text: heading,
                    textSize: IFTextSize.S,
                    textWeight: IFTextWeight.semiBold,
                  ),
                  const IFSpace(
                    space: IFSpaces.xxxS,
                  ),
                  IFText(
                    text: description,
                    textSize: IFTextSize.xS,
                    textColor: IFTextColors.DESCRIPTION,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
              color: Color(colorCode),
            ),
            child: Lottie.asset(
              lottieJson,
            ),
          ),
        ],
      );
}
