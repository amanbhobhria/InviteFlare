import 'package:get/get.dart';
import 'package:invite_flare/module/card/card/controller/card_detail_controller.dart';
import 'package:invite_flare/module/card/card/controller/sub_category_controller.dart';


class CardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardDetailController>(() => CardDetailController());
    Get.lazyPut<SubCategoryController>(() => SubCategoryController());
  }
}