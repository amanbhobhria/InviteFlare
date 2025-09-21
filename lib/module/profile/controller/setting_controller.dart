// settings_controller.dart
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/core_2/core/widgets/custom_flashbar.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/features/login/presentation/pages/login_page.dart';

class SettingsController extends GetxController {
  // Notifications list
  final oldPassword = TextEditingController();
  final emailTextController = TextEditingController();
  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();
  var notifications = <Map<String, dynamic>>[
    {
      'title': 'News & Updates',
      'subtitle': 'Receive info about new features',
      'enabled': true,
    },
    {
      'title': 'Offers & Discounts',
      'subtitle': 'Get notified about offers',
      'enabled': false,
    },
    {
      'title': 'Security Alerts',
      'subtitle': 'Important security‑related messages',
      'enabled': true,
    },
  ].obs;

  // Remove all sessions toggle
  var removeAllSessions = false.obs;

  void toggleNotification(int index, bool value) {
    notifications[index]['enabled'] = value;
    notifications.refresh(); // Manually notify because of map update
  }

  void toggleRemoveAllSessions(bool value) {
    removeAllSessions.value = value;
  }

  void callChangePasswordApi() async {
    try {
      DioClient dioClient = DioClient(Dio()); // ✅ No need to pass baseUrl
      var request = {
        'old_password': oldPassword.text,
        'new_password': newPassword.text,
        'confirmed_password': confirmPassword.text,
        'session_logout': 1,
      };
      await dioClient
          .put('v1/user/change-password', skipAuth: false, data: request)
          .then((value) async {
        if (value != null) {
          await TokenService().deleteAccessToken();
          Navigator.pushAndRemoveUntil(
            Get.context!,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
          debugPrint("User Profile: $value");
        }
      }).onError(
        (error, stackTrace) {
          NetworkExceptions.getDioException(error);
          toast(NetworkExceptions.messageData);
        },
      );
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void callDeleteAccountApi() async {
    try {
      DioClient dioClient = DioClient(Dio()); // ✅ No need to pass baseUrl
      var request = {
        'email': emailTextController.text,
      };
      await dioClient
          .post('v1/user/account/delete', skipAuth: false, data: request)
          .then((value) async {
        if (value != null) {
          await TokenService().deleteAccessToken();
          Navigator.pushAndRemoveUntil(
            Get.context!,
            MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false,
          );
          debugPrint("User Profile: $value");
        }
      }).onError(
        (error, stackTrace) {
          NetworkExceptions.getDioException(error);
          toast(NetworkExceptions.messageData);
        },
      );
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
}
//api/v1/user/account/delete
