import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/features/profile/presentation/pages/settings_page.dart';
import 'package:invite_flare/features/search/presentation/pages/search_page.dart';
import 'package:invite_flare/module/main/controller/main_controller.dart';
import 'package:invite_flare/module/main/views/category_screen.dart';
import 'package:invite_flare/module/main/views/home_screen.dart';
import 'package:invite_flare/module/main/views/search_page.dart';
import 'package:invite_flare/module/main/widget/main_view_widget.dart';
import 'package:invite_flare/module/profile/views/setting_screen.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MainController());

    return Obx(() => MainView(
      controller.pageNo,
      controller.updatePage,
      _getPage(pageNo: controller.pageNo),
    ));
  }

  Widget _getPage({required int pageNo}) {
    switch (pageNo) {
      case 0:
        return HomeScreen();
      case 1:
        return SearchScreen();
      case 2:
        return CategoriesScreen();
      case 3:
        return SettingScreen();
      default:
        return HomeScreen();
    }
  }
}




