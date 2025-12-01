import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/main/controller/home_controller.dart';
import 'package:invite_flare/module/profile/controller/profile_controller.dart';
import 'package:invite_flare/module/profile/controller/setting_controller.dart';

class ProfileBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.lazyPut<HomeController>(() => HomeController());
  }
}