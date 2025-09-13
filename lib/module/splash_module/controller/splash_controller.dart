import 'package:get/get.dart';
import 'package:invite_flare/app/navigation/app_router.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/features/login/presentation/pages/login_page.dart';
import 'package:invite_flare/features/main/presentation/pages/main_page.dart';

class SplashController extends GetxController {
  onInit() {
    super.onInit();
    callCheckApi();
  }

  callCheckApi() async {
    final tokenService = TokenService();
    print('called-------${tokenService.isLoggedIn()}');
    await Future.delayed(const Duration(seconds: 3), () {});
    if (await tokenService.isLoggedIn()) {
      Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        Get.context!,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }
}
