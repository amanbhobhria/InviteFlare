import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/splash_module/controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}