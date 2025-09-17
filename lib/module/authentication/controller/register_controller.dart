import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';

class RegisterController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var isLoading = false.obs;

  /// Call Signup API
  void callSignUpApi() async {
    try {
      isLoading.value = true;

      DioClient dioClient = DioClient(Dio());
      var request = {
        'name': nameController.text.trim(),
        'email': emailController.text.trim(),
        'password': passwordController.text.trim(),
      };

      await dioClient
          .post('SignUp', skipAuth: true, data: request)
          .then((value) {
        if (value != null) {
          // ✅ API success
          isLoading.value = false;
          Get.offAllNamed('/main'); // navigate to main page
          debugPrint("✅ Signup success: $value");
        }
      }).onError(
        (error, stackTrace) {
          isLoading.value = false;
          NetworkExceptions.getDioException(error);
          Get.snackbar("Signup Failed", NetworkExceptions.messageData);
        },
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
