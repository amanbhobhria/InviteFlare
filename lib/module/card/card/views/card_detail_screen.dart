import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/mock/mock_data.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/features/card_customize/card_customize_screen.dart';
import 'package:invite_flare/module/card/card/controller/card_detail_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/app_bar_view/app_bar_view.dart';

class CardDetailScreen extends StatelessWidget {
  final controller = Get.put(CardDetailController());

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      centerTitle: true,
      leading: InkWell(
        onTap: () => Get.back(),
        child: const Icon(Icons.arrow_back, color: Colors.black),
      ),
      // title: const Text(
      //   'Category Detail',
      //   style: TextStyle(
      //     color: Colors.black,
      //     fontWeight: FontWeight.w600,
      //     fontSize: 18,
      //   ),
      // ),
    ),



    //
    // appBar: AppBar(
    //
    //   title: const Text('Card Detail'),
    //   leading: IconButton(
    //     icon: const Icon(Icons.arrow_back),
    //     onPressed: () {
    //       // Use Get.back() to handle the back action
    //       Get.back();
    //     },
    //   ),
    // ),
    //


      // appBar: const AppBarView.other(pageTitle: '',),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final card = controller.cardData.value;
        if (card == null) {
          return const Center(child: Text("No card found"));
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Card Image
              IFImageView(
                url: card.thumb ?? '',
                borderRadius: 0,
                width: double.infinity,
                height: 250,
              ),

              const SizedBox(height: 16),

              /// Title
              Center(
                child: IFHeading(
                  text: card.title ?? '',
                  headingSize: IFHeadingSize.xxxxL,
                  textWeight: IFTextWeight.regular,
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 8),

              /// Description
              Center(
                child: IFText(
                  text: card.description ?? '',
                  textAlign: TextAlign.center,
                  textSize: IFTextSize.S,
                ),
              ),

              const SizedBox(height: 24),

              /// Static Features
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IFCard(
                  borderRadius: BorderRadius.circular(16),
                  surfaceColor: const Color(0x91f1f1f1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Column(
                      children: [
                        _buildFeature("Unlimited free downloads"),
                        _buildFeature("Free invite link sharing"),
                        _buildFeature("Collect RSVPs & track in real time"),
                        _buildFeature("Customizable fonts, colors, layouts"),
                        _buildFeature("Eco-friendly & paperless"),
                        _buildFeature("Priority support for subscribers"),
                        _buildFeature("Your info is private & never shared"),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// Customize Button
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: IFColors.BRAND,
                    padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CardCustomizePage(card.id ?? ''),
                      ),
                    );
                  },
                  icon: const Icon(Icons.color_lens, color: Colors.white),
                  label: const Text(
                    "Customize",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              /// Design Description (Static)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IFHeading(
                  text: "Design Description",
                  headingSize: IFHeadingSize.xL,
                  textWeight: IFTextWeight.regular,
                ),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: IFText(
                  text:
                  "This is a sample design description. Currently static but can be dynamic later.",
                  textSize: IFTextSize.S,
                ),
              ),

              const SizedBox(height: 32),

              /// Related Cards Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: IFHeading(
                  text: "You might also like",
                  headingSize: IFHeadingSize.xL,
                  textWeight: IFTextWeight.regular,
                ),
              ),

              const SizedBox(height: 16),

              Obx(() => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: controller.relatedCards.length,
                  itemBuilder: (context, index) {
                    final related = controller.relatedCards[index];
                    return GestureDetector(
                      onTap: () {
                        controller.id = related.id;
                        controller.callCardDetailApi(); // reload with new card
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IFImageView(
                            url: related.thumb ?? '',
                            borderRadius: 12,
                            height: 150,
                            width: double.infinity,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            related.title ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                )),

              const SizedBox(height: 32),
            ],
          ),
        );
      }),
    );

  /// helper for features row
  Widget _buildFeature(String text) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Row(
        children: [
          const Icon(Icons.check, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
}