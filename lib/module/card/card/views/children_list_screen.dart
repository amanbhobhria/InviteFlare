import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/core_2/core/values/app_colors.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/card/controller/children_list_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/category_view/category_tile.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/card/controller/children_list_controller.dart';

class ChildrenListScreen extends StatelessWidget {
  final controller = Get.put(ChildrenListController());

  @override
  Widget build(BuildContext context) => GetBuilder<ChildrenListController>(
      init: controller,
      builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            leading: InkWell(
              onTap: () => Get.back(),
              child: const Icon(Icons.arrow_back, color: Colors.black),
            ),
            title: const Text(
              'SubCategory',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
          ),
          body: Column(
            children: [

              const SizedBox(height: 12),

              /// Subcategory Grid
              Expanded(
                child: Obx(
                      () => GridView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // ✅ 2 for better readability
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.9,
                    ),
                    itemCount: controller.childrenList.length,
                    itemBuilder: (context, index) {
                      final item = controller.childrenList[index];

                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.cardListScreen, arguments: {
                            'slug': item.slug ?? ""
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: appColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: appColor.withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /// Circle Avatar with Icon or First Letter
                              CircleAvatar(
                                radius: 28,
                                backgroundColor: appColor,
                                child: Text(
                                  (item.title?.substring(0, 1) ?? "?")
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              /// Title
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  item.title ?? "",
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
                ),
              ),
            ],
          ),
        ),
    );
}

