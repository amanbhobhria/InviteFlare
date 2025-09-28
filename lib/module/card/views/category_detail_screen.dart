import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< Updated upstream
import 'package:get/get_core/src/get_main.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/core_2/core/widgets/custom_appbar.dart';
=======
>>>>>>> Stashed changes
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/module/card/controller/category_detail_controller.dart';
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
<<<<<<< Updated upstream
                  // ignore: prefer_const_constructors
=======
>>>>>>> Stashed changes
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
<<<<<<< Updated upstream
              // ignore: prefer_const_constructors
=======
>>>>>>> Stashed changes
              title: Text('Category Detail'),
            ),
            body: Column(
              children: [
                Obx(
                  () => Expanded(
                    child: GridView.builder(
<<<<<<< Updated upstream
                      // ignore: prefer_const_constructors
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: controller.categoryList.length,
                      // ignore: prefer_expression_function_bodies
=======
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemCount: controller.categoryList.length,
>>>>>>> Stashed changes
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
