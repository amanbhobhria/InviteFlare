import 'package:flutter_svg/svg.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';

class RecentSearchItem extends StatelessWidget {
  final String text;
  final Function() onTapDelete;

  const RecentSearchItem({
    super.key,
    required this.text,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: IFColors.BLACK_LIGHTER),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IFText(
              text: text,
              textSize: IFTextSize.S,
            ),
            const IFSpace(
              space: IFSpaces.xS,
              direction: IFSpaceDirection.HORIZONTAL,
            ),
            InkWell(
              onTap: onTapDelete,
              child: SvgPicture.asset(IFIcons.cross),
            )
          ],
        ),
      );
}
