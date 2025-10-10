import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/core_2/routes/app_routes.dart';

import 'package:invite_flare/module/card/card/controller/category_detail_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/category_view/category_tile.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/core_2/routes/app_routes.dart';
import 'package:invite_flare/module/card/card/controller/category_detail_controller.dart';

class CategoryDetailScreen extends StatelessWidget {
  final controller = Get.put(CategoryDetailController());

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        centerTitle: true,
        leading: InkWell(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Category Detail',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Obx(
              () {
            if (controller.categoryList.isEmpty) {
              return const Center(
                child: Text(
                  "No subcategories available",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              );
            }

            return GridView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: controller.categoryList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // ✅ 2 columns
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemBuilder: (context, index) {
                final category = controller.categoryList[index];

                return GestureDetector(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.childrenListScreen,
                      arguments: {
                        'childrenList': category.children ?? [],
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: appColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// Circular Icon / Placeholder
                        CircleAvatar(
                          radius: 28,
                          backgroundColor: appColor,
                          child: Text(
                            (category.title?.substring(0, 1) ?? "?")
                                .toUpperCase(),
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// Title Text
                        Text(
                          category.title ?? "",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
}

