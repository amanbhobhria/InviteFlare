import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/core/base/base.dart';

class InvitationCardTile extends StatelessWidget {
  final String imageUrl;
  final String name;

  const InvitationCardTile({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) => SizedBox(
        width: context.width / 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            IFImageView(
              height: 150,
              url: imageUrl,
              fit: BoxFit.cover,
            ),
            const IFSpace(
              space: IFSpaces.xxS,
            ),
            IFText(
              text: name,
              textAlign: TextAlign.center,
              textSize: IFTextSize.S,
            )
          ],
        ),
      );
}
