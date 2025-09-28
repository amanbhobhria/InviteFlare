import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/core_2/routes/app_routes.dart';
import 'package:invite_flare/module/main/controller/home_controller.dart';
import 'package:invite_flare/module/main/model/categories_response_model.dart';
import 'package:invite_flare/module/main/side_bar/side_nav.dart';
import 'package:invite_flare/module/main/widget/home_widget/category_tiles_row_widget.dart';
import 'package:invite_flare/module/main/widget/home_widget/expandable_card_view.dart';
import 'package:invite_flare/module/main/widget/home_widget/explainer_section_view.dart';
import 'package:invite_flare/module/main/widget/home_widget/promo_banner_widget.dart';
import 'package:invite_flare/module/main/widget/home_widget/slogan_view_widget.dart';
import 'package:invite_flare/shared/presentation/presentation.dart';

import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/di/di.dart'; // getIt

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(
      HomeController(),
    );

    return Scaffold(
      key: homeController.scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBarView.home(
        notificationCount: 4,
        appBarEnum: AppBarEnum.home,
        onNotificationPressed: () {},
        onProfilePressed: () {
          print('Check Daratatattata-------');
          homeController.scaffoldKey.currentState?.openDrawer();
        },
      ),
      drawer: SideNav(
        scaffoldKey: homeController.scaffoldKey,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Categories
            Obx(() {
              if (homeController.isCategoryLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Row(
                  children: List.generate(
                    homeController.cateroiesResponseModel?.length ?? 0,
                    (index) {
                      CateroiesResponseModel category =
                          homeController.cateroiesResponseModel[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: CategoryTile(
                          name: category.title ?? '',
                          icon: category.slug ?? '',
                          cardColor: Utilities.colorFromHex(
                              category.bgColor ?? '#fbf6ee'),
                          onTap: () {
                            debugPrint('Category Tapped');
                            // Get.to(() => CardDetailScreen());
                            Get.toNamed(AppRoutes.cardDetailScreen);
                          },
                        ),
                      );
                    },
                  ),
                ),
              );

              ;
            }),

            // Promo Banner
            const PromoBannerWidget(),

            const IFSpace(),
            Divider(thickness: 8, color: Colors.grey.shade100),

            // Expandable Card 1
            Obx(() {
              if (homeController.isExpandableLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ExpandableCardView(
                heading: 'Heading',
                description: homeController.expandableCardData['description'],
                invitationCards: homeController.expandableCardData['cards'],
              );
            }),

            Divider(thickness: 8, color: Colors.grey.shade100),

            // Expandable Card 2
            // Obx(() {
            //   if (homeController.isExpandableLoading.value) {
            //     return const Center(child: CircularProgressIndicator());
            //   }
            //   return ExpandableCardView(
            //     heading: homeController.expandableCardData['heading'],
            //     description: homeController.expandableCardData['description'],
            //     invitationCards: homeController.expandableCardData['cards'],
            //   );
            // }),

            Divider(thickness: 8, color: Colors.grey.shade100),

            // Explainer Section
            Obx(() {
              if (homeController.isExplainerLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ExplainerSectionView(
                heading: homeController.explainerData['heading'],
                steps: homeController.explainerData['section'],
              );
            }),

            Divider(thickness: 8, color: Colors.grey.shade100),

//             const SloganWidget(
//               heading: 'Save Environment',
//               sloganText: '''
// Green leaves whisper, life they bring, Save the trees, let nature sing!''',
//             ),

//             const IFSpace(space: IFSpaces.xxxxxxL),
//             const IFSpace(space: IFSpaces.xxxxL),
          ],
        ),
      ),
    );
  }
}
