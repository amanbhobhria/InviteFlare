import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';

class InvitationCardItem extends StatelessWidget {
  final String imageURL;
  final String cardTitle;

  //final List<Color> colorOptions;
  final Function()? onTapInvitationCard;

  const InvitationCardItem({
    super.key,
    required this.imageURL,
    required this.cardTitle,
    this.onTapInvitationCard,
    //required this.colorOptions,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTapInvitationCard,
        child: Wrap(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 0.71 / 1,
                  child: IFImageView(
                    url: imageURL,
                    fit: BoxFit.cover,
                    elevation: 1,
                  ),
                ),
                const IFSpace(
                  space: IFSpaces.xxxS,
                ),
                IFText(
                  text: cardTitle,
                  textSize: IFTextSize.S,
                  textWeight: IFTextWeight.semiBold,
                  textAlign: TextAlign.center,
                ),
                const IFSpace(
                  space: IFSpaces.xxS,
                ),
                // Offstage(
                //   offstage: colorOptions.isEmpty,
                //   child: SingleChildScrollView(
                //     scrollDirection: Axis.horizontal,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       mainAxisSize: MainAxisSize.min,
                //       children: List.generate(
                //         colorOptions.length,
                //         (index) => Padding(
                //           padding: const EdgeInsets.symmetric(horizontal: 4.0),
                //           child: Icon(
                //             Icons.brightness_1,
                //             color: colorOptions[index],
                //           ),
                //         ),
                //       ).toList(),
                //     ),
                //   ),
                // ),
                const IFSpace(
                  space: IFSpaces.xxS,
                ),
              ],
            ),
          ],
        ),
      );
}
