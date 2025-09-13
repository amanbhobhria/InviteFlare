import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:invite_flare/core_2/data/internet_connection/no_internet_screen.dart';
import '../../../export.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      // offlineSheet();
      Get.to(NoInternetConnectionScreen(
        screenType: 0,
      ));
    } else if (Get.previousRoute != AppRoutes.splash) {
      Get.back();
      update();
    } else {
      Get.offAllNamed(AppRoutes.splash);
    }
  }
}
