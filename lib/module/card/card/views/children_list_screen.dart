import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/card/controller/children_list_controller.dart';
import 'package:invite_flare/shared/presentation/widgets/category_view/category_tile.dart';

class ChildrenListScreen extends StatelessWidget {
  final controller = Get.put(ChildrenListController());

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return GetBuilder<ChildrenListController>(
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
              title: const Text('SubCategory Screen'),
            ),
            body: Column(
              children: [
                Obx(
                  () => Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: controller.childrenList.length,
                      itemBuilder: (context, index) => CategoryTile(
                        name: controller.childrenList[index].title ?? "",
                        icon: controller.childrenList[index].slug ?? "",
                        cardColor: Utilities.colorFromHex('#9AD9F6'),
                        onTap: () {
                          Get.toNamed(AppRoutes.cardListScreen, arguments: {
                            'slug': controller.childrenList[index].slug ?? ""
                          });
                        },
                      ),
                    ).marginSymmetric(horizontal: 10),
                  ),
                )
              ],
            ));
      },
    );
  }
}
