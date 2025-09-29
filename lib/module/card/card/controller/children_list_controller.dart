import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/main/model/category_data_response_model.dart';

class ChildrenListController extends GetxController {
  RxList<Children> childrenList = <Children>[].obs;

  @override
  void onInit() {
    getArgument();
    super.onInit();
  }

  getArgument() {
    if (Get.arguments != null) {
      childrenList.value = Get.arguments['childrenList'] ?? [];
      print('object-------${Get.arguments}');
    }
  }
}
