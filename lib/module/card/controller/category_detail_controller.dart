import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/main/model/categories_response_model.dart';

class CategoryDetailController extends GetxController {
  RxList<Category> categoryList = <Category>[].obs;

  getArgument() {
    if (Get.arguments != null) {
      categoryList.value = Get.arguments['category'] as List<Category>;
      print('object-------${categoryList.length}');
    }
  }

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }
}
