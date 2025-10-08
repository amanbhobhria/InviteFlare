import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/module/card/card/views/category_detail_screen.dart';
import 'package:invite_flare/module/main/controller/category_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/loading_view/loading_view.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoriesController());

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        title: const Text(
          "Categories",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingView();
        }

        if (controller.cateroiesResponseModel.isEmpty) {
          return const Center(
            child: Text(
              "No categories available",
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          );
        }

        return SafeArea(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // ✅ 2 columns (easier to browse)
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.9,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: controller.cateroiesResponseModel.length,
            itemBuilder: (context, index) {
              final category = controller.cateroiesResponseModel[index];

              return InkWell(
                onTap: () {
                  Get.to(
                        () =>  CategoryDetailScreen(),
                    arguments: {'category': category.children ?? []},
                  );
                },
                borderRadius: BorderRadius.circular(16),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      /// Icon / Placeholder
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                          color: appColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            category.slug?.substring(0, 1).toUpperCase() ?? "?",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: appColor,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      /// Category Name
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          category.title ?? "Untitled",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 15,
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
    );
  }
}
