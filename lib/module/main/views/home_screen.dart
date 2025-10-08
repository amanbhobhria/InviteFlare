import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/core_2/routes/app_routes.dart';
import 'package:invite_flare/module/card/card/views/category_detail_screen.dart';
import 'package:invite_flare/module/main/controller/home_controller.dart';
import 'package:invite_flare/module/main/model/categories_response_model.dart';
import 'package:invite_flare/module/main/model/category_data_response_model.dart';
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
// Categories Horizontal List (Improved placeholder)
            Obx(() {
              if (homeController.isCategoryLoading.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final categories = homeController.cateroiesResponseModel ?? [];

              return SizedBox(
                height: 160, // fixed height for horizontal cards
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    return GestureDetector(
                      onTap: () {
                        debugPrint('Category Tapped: ${category.children}');
                        Get.to(
                              () =>  CategoryDetailScreen(),
                          arguments: {'category': category.children ?? []},
                        );



                        // Get.toNamed(AppRoutes.cardDetailScreen, arguments: {
                        //   'category': category,
                        // });
                      },
                      child: Container(
                        width: 140,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Placeholder top block instead of avatar
                            Container(
                              height: 90,
                              decoration: BoxDecoration(
                                color: Utilities.colorFromHex('#fde7c2'),
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.category,
                                  size: 36,
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                category.title ?? '',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }),







            // // Categories
            // Obx(() {
            //   if (homeController.isCategoryLoading.value) {
            //     return const Center(child: CircularProgressIndicator());
            //   }
            //   return SingleChildScrollView(
            //     scrollDirection: Axis.horizontal,
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            //     child: Row(
            //       children: List.generate(
            //         homeController.cateroiesResponseModel?.length ?? 0,
            //         (index) {
            //           CategoriesData category =
            //               homeController.cateroiesResponseModel[index];
            //           return Padding(
            //             padding: const EdgeInsets.only(right: 12),
            //             child: CategoryTile(
            //               name: category.title ?? '',
            //               icon: category.slug ?? '',
            //               cardColor: Utilities.colorFromHex('#fbf6ee'),
            //               onTap: () {
            //                 debugPrint('Category Tapped');
            //                 // Get.to(() => CardDetailScreen());
            //                 Get.toNamed(AppRoutes.cardDetailScreen);
            //               },
            //             ),
            //           );
            //         },
            //       ),
            //     ),
            //   );
            //
            //   ;
            // }),

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
            Obx(() {
              if (homeController.isExpandableLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return ExpandableCardView(
                heading: homeController.expandableCardData['heading'],
                description: homeController.expandableCardData['description'],
                invitationCards: homeController.expandableCardData['cards'],
              );
            }),

            Divider(thickness: 8, color: Colors.grey.shade100),

            // Explainer Section
            // Obx(() {
            //   if (homeController.isExplainerLoading.value) {
            //     return const Center(child: CircularProgressIndicator());
            //   }
            //   return ExplainerSectionView(
            //     heading: homeController.explainerData['heading'],
            //     steps: homeController.explainerData['section'],
            //   );
            // }),

            Divider(thickness: 8, color: Colors.grey.shade100),

            const SloganWidget(
              heading: 'Save Environment',
              sloganText: '''
Green leaves whisper, life they bring, Save the trees, let nature sing!''',
            ),

            const IFSpace(space: IFSpaces.xxxxxxL),
            const IFSpace(space: IFSpaces.xxxxL),
          ],
        ),
      ),
    );
  }
}
