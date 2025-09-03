import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:lottie/lottie.dart';

class SloganView extends StatelessWidget {
  final String heading;
  final String sloganText;

  const SloganView({
    super.key,
    required this.heading,
    required this.sloganText,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        height: context.width / 1.2,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IFHeading(
                    text: heading,
                    textAlign: TextAlign.start,
                    textColor: IFTextColors.HINT,
                    textWeight: IFTextWeight.bold,
                    headingSize: IFHeadingSize.xxxxxxL,
                  ),
                  IFText(
                    text: sloganText,
                    textAlign: TextAlign.start,
                    textSize: IFTextSize.L,
                    textWeight: IFTextWeight.light,
                    textColor: IFTextColors.DESCRIPTION,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: -30,
              left: -65,
              child: RotatedBox(
                quarterTurns: 5,
                child: Lottie.asset(
                  'assets/lottie/slogon_leaf1.json',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Positioned(
              right: -60,
              top: -60,
              child: RotatedBox(
                quarterTurns: -5,
                child: Lottie.asset(
                  'assets/lottie/slogon_leaf.json',
                  width: 200,
                  height: 200,
                ),
              ),
            ),
          ],
        ),
      );
}
