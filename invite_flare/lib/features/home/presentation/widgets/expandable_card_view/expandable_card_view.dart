import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/event_details/presentation/pages/event_details_page.dart';
import 'package:invite_flare/features/splash/presentation/presentation.dart';

class ExpandableCardView extends BaseStatelessWidget {
  final String heading;
  final String description;
  final List<Map<String, dynamic>> invitationCards;
  const ExpandableCardView({
    super.key,
    required this.heading,
    required this.description,
    required this.invitationCards,
  });

  @override
  Widget buildWidget(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IFText(
              text: heading,
              textSize: IFTextSize.L,
              textWeight: IFTextWeight.semiBold,
            ),
            IFText(
              text: description,
              textAlign: TextAlign.center,
              textSize: IFTextSize.xS,
              textWeight: IFTextWeight.light,
              textColor: IFTextColors.DESCRIPTION,
            ),
            const IFSpace(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InvitationCardTile(
                  imageUrl: invitationCards[0]['image'],
                  name: invitationCards[0]['name'],
                ),
                const IFSpace(
                  direction: IFSpaceDirection.HORIZONTAL,
                ),
                InvitationCardTile(
                  imageUrl: invitationCards[1]['image'],
                  name: invitationCards[1]['name'],
                ),
                const IFSpace(
                  direction: IFSpaceDirection.HORIZONTAL,
                ),
                InvitationCardTile(
                  imageUrl: invitationCards[2]['image'],
                  name: invitationCards[2]['name'],
                ),
              ],
            ),
            const IFSpace(),
            IFButton(
              text: 'Explore',
              buttonSize: IFButtonSize.MIN,
              buttonType: IFButtonType.SECONDARY,
              buttonStyle: IFButtonStyle.OUTLINE,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const EventDetailsPage())
                );
              },
            )
          ],
        ),
      );
}
