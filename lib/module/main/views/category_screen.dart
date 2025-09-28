import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/module/card/card/views/category_detail_screen.dart';
import 'package:invite_flare/module/main/controller/category_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/category_view/category_tile.dart';
import 'package:invite_flare/shared/presentation/widgets/loading_view/loading_view.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());

    return GetBuilder<CategoriesController>(
      init: controller,
      // ignore: prefer_expression_function_bodies
      builder: (controller) {
        return Obx(() {
          if (controller.isLoading.value) {
            return const LoadingView();
          }

          return SafeArea(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: controller.cateroiesResponseModel.length,
              itemBuilder: (context, index) {
                final category = controller.cateroiesResponseModel[index];

                return CategoryTile(
                  name: controller.cateroiesResponseModel[index].title ?? "",
                  icon: controller.cateroiesResponseModel[index].slug ?? "",
                  cardColor: Utilities.colorFromHex(
                      controller.cateroiesResponseModel[index].bgColor ??
                          "#9AD9F6"),
                  onTap: () {
                    Get.to(() => CategoryDetailScreen(), arguments: {
                      'category':
                      controller.cateroiesResponseModel[index].category,
                    });
                  },
                );
              },
            ),
          );
        });
      },
    );
  }
}