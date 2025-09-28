import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/core_2/core/widgets/custom_appbar.dart';
import 'package:invite_flare/module/card/card/controller/category_detail_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/category_view/category_tile.dart';

class CategoryDetailScreen extends StatelessWidget {
  final controller = Get.put(CategoryDetailController());

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return GetBuilder<CategoryDetailController>(
      init: controller,
      // ignore: prefer_expression_function_bodies
      builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              title: Text('Category Detail'),
            ),
            body: Column(
              children: [
                Obx(
                  () => Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: controller.categoryList.length,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          name: controller.categoryList[index].title ?? "",
                          icon: controller.categoryList[index].slug ?? "",
                          cardColor: Utilities.colorFromHex(
                              controller.categoryList[index].bgColor ??
                                  '#9AD9F6'),
                          onTap: () {},
                        );
                      },
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}
