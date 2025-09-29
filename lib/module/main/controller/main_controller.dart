import 'package:get/get.dart';
import 'package:invite_flare/module/main/controller/category_controller.dart';
import 'package:invite_flare/module/main/controller/home_controller.dart';

class MainController extends GetxController {
  final RxInt _pageNo = 0.obs;

  int get pageNo => _pageNo.value;
  set pageNo(int value) => _pageNo.value = value;

  void updatePage(int index) {
    pageNo = index;
    if (pageNo == 0) {
      Get.put(HomeController())
          .onInit(); // Clear search text or any other state if needed
    }else if(pageNo == 2){
   Get.put(CategoriesController())
          .fetchCategories(); // Clear search text or any other state if needed
    }
  }
}
