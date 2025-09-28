import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/mock/mock_data.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/features/card_customize/card_customize_screen.dart';
import 'package:invite_flare/module/card/controller/card_detail_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/app_bar_view/app_bar_view.dart';

class CardDetailScreen extends StatelessWidget {
  final controller = CardDetailController();
  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarView.other(
        pageTitle: '',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IFCard(
                width: context.width,
                height: context.width,
                surfaceColor: const Color(0x91ffd59c),
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: const EdgeInsets.all(60.0),
                  child: IFImageView(
                    url: '',
                    borderRadius: 10,
                  ),
                ),
              ),
              const IFSpace(
                space: IFSpaces.xL,
              ),
              IFHeading(
                text: "card.title ?? ''",
                headingSize: IFHeadingSize.xxxxL,
                textWeight: IFTextWeight.regular,
                textAlign: TextAlign.center,
              ),
              const IFSpace(
                space: IFSpaces.xxxS,
              ),
              IFText(
                text: MockData.cardDescription,
                textAlign: TextAlign.center,
                textSize: IFTextSize.xS,
              ),
              const IFSpace(
                space: IFSpaces.xxxL,
              ),
              IFCard(
                borderRadius: BorderRadius.circular(16),
                surfaceColor: const Color(0x91f1f1f1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      MockData.cardOffers.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: IFColors.BRAND,
                            ),
                            const IFSpace(
                              space: IFSpaces.xS,
                              direction: IFSpaceDirection.HORIZONTAL,
                            ),
                            Expanded(
                              child: IFText(
                                text: MockData.cardOffers[index],
                                textSize: IFTextSize.S,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const IFSpace(
                space: IFSpaces.xxxxxxL,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CardCustomizePage(
                " card.id ?? ''",
              ),
            ),
          );
        },
        icon: const Icon(
          Icons.color_lens,
          color: Colors.white,
        ),
        label: const IFText(
          text: 'Customize',
          textAlign: TextAlign.center,
          textColor: IFTextColors.WHITE,
        ),
      ),
    );
  }
}
