import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/card/controller/card_list_controller.dart';

class CardListScreen extends StatelessWidget {
  final controller = Get.put(CardListController());

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return GetBuilder<CardListController>(
      init: controller,
      // ignore: prefer_expression_function_bodies
      builder: (controller) {
        return Scaffold(
          // appBar: AppBar(
          //   backgroundColor: Colors.white,
          //   leading: InkWell(
          //       onTap: () {
          //         Get.back();
          //       },
          //       child: Icon(
          //         Icons.arrow_back,
          //         color: Colors.black,
          //       )),
          //   title: const Text('Card List Screen'),
          // ),
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                floating: true,
                stretch: true,
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                title: const IFHeading(
                  text: 'Search',
                  headingSize: IFHeadingSize.xxxL,
                  textWeight: IFTextWeight.regular,
                ),
              ),

              /// Content (Recent / Results)
              SliverToBoxAdapter(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  // If results exist, show results
                  if (controller.cardsListData != null &&
                      controller.cardsListData.isNotEmpty == true) {
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(12),
                      itemCount: controller.cardsListData.length,
                      separatorBuilder: (_, __) =>
                          const Divider().marginOnly(top: 10, bottom: 15),
                      itemBuilder: (context, index) {
                        final item = controller.cardsListData[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.cardDetailScreen, arguments: {
                              'id': controller.cardsListData[index].id
                            });
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              item.thumb != null
                                  ? Image.network(
                                      controller.cardsListData[index].thumb,
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    )
                                  : const Icon(Icons.image, size: 120),
                              const SizedBox(height: 8),
                              Text(
                                controller.cardsListData[index].title
                                        .toString()
                                        .capitalizeFirst ??
                                    "",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }

                  // No results -> show recent searches

                  // No recent, no results
                  return const Padding(
                    padding: EdgeInsets.all(24.0),
                    child: Center(child: Text("No results found")),
                  );
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
