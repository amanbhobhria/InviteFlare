import 'package:get/get.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/main/views/main_screen.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  final TextEditingController emailCtrl =
      TextEditingController(text: 'gauravnarulain@gmail.com');
  final TextEditingController passwordCtrl =
      TextEditingController(text: 'Admin@123');
  // Mock login function (replace with API call)
  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.dialog(
        AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Email and Password cannot be empty'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 2)); // simulate API call

      if (email.value == "gauravnarulain@gmail.com" &&
          password.value == "Admin@123") {
        // Success
        Get.offAllNamed('/main'); // Navigate to MainPage
      } else {
        Get.dialog(
          AlertDialog(
            title: const Text('Login Failed'),
            content: const Text('Invalid email or password'),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } finally {
      isLoading.value = false;
    }
  }

  void callLoginApi2() async {
    try {
      isLoading.value = true;
      DioClient dioClient = DioClient(Dio()); // ✅ Same as update profile

      var request = {
        'email': emailCtrl.text.trim(),
        'password': passwordCtrl.text.trim(),
      };

      await dioClient
          .post('v1/auth/login', skipAuth: true, data: request)
          .then((value) async {
        if (value != null) {
          final tokenService = TokenService();
          await tokenService.saveAccessToken(value['data']['access_token']);
          await tokenService.saveRefreshToken(value['data']['refresh_token']);
          await tokenService.saveSession(isLoggedIn: true);
          isLoading.value = false;
          Get.offAll(() => MainScreen()); // navigate to home/main
          debugPrint("✅ Login success: $value");
        }
      }).onError(
        (error, stackTrace) {
          isLoading.value = false;
          NetworkExceptions.getDioException(error);
          Get.snackbar("Login Failed", NetworkExceptions.messageData);

        },
      );
    } catch (e) {
      isLoading.value = false;
   Get.snackbar("Login Failed", e.toString());
      debugPrint("🔥 Error: $e");
    }
  }
}
