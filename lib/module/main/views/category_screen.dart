import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/global_search/presentation/widgets/categories_view/categories_view.dart';
import 'package:invite_flare/module/main/controller/category_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/loading_view/loading_view.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(getIt<CategoriesController>());

    return Obx(() {
      if (controller.isLoading.value) {
        return const LoadingView();
      }

      return CategoriesView(categories: controller.categories);
    });
  }
}
