import 'package:get/get.dart';
import 'package:invite_flare/app/navigation/app_router.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/module/authentication/views/login_screen.dart';
import 'package:invite_flare/module/main/views/main_screen.dart';

class SplashController extends GetxController {
  onInit() {
    super.onInit();
    callCheckApi();
  }

  callCheckApi() async {
    final tokenService = TokenService();
    await Future.delayed(const Duration(seconds: 3), () {});
    if (await tokenService.isLoggedIn()) {
      Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(builder: (context) => MainScreen()),
        (Route<dynamic> route) => false,
      );
    } else {
      Get.to(() => MainScreen());
    }
  }
}
