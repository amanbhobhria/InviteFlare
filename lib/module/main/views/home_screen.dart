import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/module/card/card/views/category_detail_screen.dart';
import 'package:invite_flare/module/main/controller/home_controller.dart';
import 'package:invite_flare/module/main/side_bar/side_nav.dart';
import 'package:invite_flare/module/main/widget/home_widget/expandable_card_view.dart';
import 'package:invite_flare/module/main/widget/home_widget/promo_banner_widget.dart';
import 'package:invite_flare/module/main/widget/home_widget/slogan_view_widget.dart';
import 'package:invite_flare/shared/presentation/presentation.dart';

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
            Obx(() {
              if (homeController.isCategoryLoading.value) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final categories = homeController.cateroiesResponseModel ?? [];

              return SizedBox(
                height: 160,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 12),
                  itemBuilder: (context, index) {
                    final category = categories[index];

                    final bgColor = homeController.categoryBgColors[
                        index % homeController.categoryBgColors.length];

                    final iconPath = homeController.categoryIcons[
                        index % homeController.categoryIcons.length];

                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => CategoryDetailScreen(),
                          arguments: {
                            'category': category.children ?? [],
                            'image': category.images,
                          },
                        );
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
                        child: Container(
                          decoration: BoxDecoration(
                            color: bgColor,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// Icon
                              Image.asset(
                                iconPath,
                                width: 56,
                                height: 56,
                                fit: BoxFit.contain,
                              ),

                              const SizedBox(height: 8),

                              /// Title inside background
                              Text(
                                category.title ?? '',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),

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
