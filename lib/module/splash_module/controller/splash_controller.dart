import 'package:get/get.dart';
import 'package:invite_flare/app/navigation/app_router.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/features/main/presentation/pages/main_page.dart';
import 'package:invite_flare/module/authentication/views/login_screen.dart';

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
        MaterialPageRoute(builder: (context) => MainPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      Get.to(() => LoginScreen());
    }
  }
}
