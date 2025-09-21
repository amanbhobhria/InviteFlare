import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/home_2/controlller/search_controller.dart';

class Home2Binding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<SearchCategoryController>(() => SearchCategoryController());

  }
}