import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/card/controller/card_list_controller.dart';

class CardListScreen extends StatelessWidget {
  final controller = Get.put(CardListController());

  @override
  Widget build(BuildContext context) => GetBuilder<CardListController>(
      init: controller,
      builder: (controller) => Scaffold(
          backgroundColor: Colors.grey[50],
          body: CustomScrollView(
            slivers: [
              /// AppBar
              SliverAppBar(
                pinned: true,
                floating: true,
                stretch: true,
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 1,
                surfaceTintColor: Colors.white,
                leading: InkWell(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                title: const IFHeading(
                  text: 'Cards',
                  headingSize: IFHeadingSize.xxxL,
                  textWeight: IFTextWeight.regular,
                ),
              ),

              /// Content
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverToBoxAdapter(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 48),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (controller.cardsListData != null &&
                        controller.cardsListData.isNotEmpty) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.cardsListData.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                        itemBuilder: (context, index) {
                          final item = controller.cardsListData[index];

                          return GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.cardDetailScreen,
                                  arguments: {'id': item.id});
                            },
                            child: Container(
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
                                  // Card image / placeholder
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16)),
                                    child: item.thumb != null
                                        ? Image.network(
                                      item.thumb,
                                      height: 140,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                        : Container(
                                      height: 140,
                                      color: Colors.grey[200],
                                      child: const Icon(
                                        Icons.image_not_supported,
                                        color: Colors.grey,
                                        size: 48,
                                      ),
                                    ),
                                  ),

                                  // Title
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Text(
                                      item.title.toString().capitalizeFirst ?? "",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black87,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }

                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 48),
                      child: Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
    );
}
