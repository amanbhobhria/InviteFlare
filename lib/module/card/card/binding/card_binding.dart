import 'package:get/get.dart';
import 'package:invite_flare/module/card/card/controller/card_detail_controller.dart';
import 'package:invite_flare/module/card/card/controller/card_list_controller.dart';
import 'package:invite_flare/module/card/card/controller/children_list_controller.dart';
import 'package:invite_flare/module/card/card/controller/customize_controller.dart';
import 'package:invite_flare/module/card/card/controller/sub_category_controller.dart';


class CardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardDetailController>(() => CardDetailController());
    Get.lazyPut<SubCategoryController>(() => SubCategoryController());
    Get.lazyPut<ChildrenListController>(() => ChildrenListController());
    Get.lazyPut<CardListController>(() => CardListController());
    Get.lazyPut<CustomizeController>(() => CustomizeController());
  }
}