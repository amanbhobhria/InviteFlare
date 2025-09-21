import 'package:image_picker/image_picker.dart';
import 'package:invite_flare/core/exceptions/app_exception.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/profile/model/profile_response_model.dart';

class ProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();

  File? profileImage;
  final nameController = TextEditingController(text: "John Doe");
  final emailController = TextEditingController(text: "john.doe@email.com");
  final phoneController = TextEditingController();
  ProfileResponseModel profileResponseModel = ProfileResponseModel();
  bool isTwoFactorEnabled = false;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      update();
    }
  }

  void toggleTwoFactor(bool value) {
    if (value && phoneController.text.isEmpty) {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(
          content:
              Text("Enter phone number to enable Two-Factor Authentication"),
        ),
      );
      return;
    }

    isTwoFactorEnabled = value;
    update();
  }

  void saveProfile() {
    if (formKey.currentState!.validate()) {
      // Later: Call your Bloc event or repository to save
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        const SnackBar(content: Text("Profile saved successfully")),
      );
    }
  }

  void fetchMyData() async {
    try {
      DioClient dioClient = DioClient(Dio()); // ✅ No need to pass baseUrl

      await dioClient.get('v1/user', skipAuth: false).then((value) {
        if (value != null) {
          profileResponseModel = ProfileResponseModel.fromJson(value);
          setData();
          print('ProfileDatatatattatatata------${profileResponseModel.name}');
          debugPrint("User Profile: $value");
        }
      }).onError(
        (error, stackTrace) {
          NetworkExceptions.getDioException(error);
        },
      );
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  void callUpdateProfileApi() async {
    try {
      DioClient dioClient = DioClient(Dio()); // ✅ No need to pass baseUrl
      var request = {
        'name': nameController.text,
        'profile_image': '',
        'contact': phoneController.text,
        'two_factor': isTwoFactorEnabled ? 1 : 0,
      };
      await dioClient
          .put('v1/user/update', skipAuth: false, data: request)
          .then((value) {
        if (value != null) {
          profileResponseModel = ProfileResponseModel.fromJson(value);
          Get.back();
          print('ProfileDatatatattatatata------${profileResponseModel.name}');
          debugPrint("User Profile: $value");
        }
      }).onError(
        (error, stackTrace) {
          toast(NetworkExceptions.messageData);
          NetworkExceptions.getDioException(error);
        },
      );
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
    fetchMyData();
  }

  setData() {
    nameController.text = profileResponseModel.name ?? "";
    emailController.text = profileResponseModel.email ?? "";
    phoneController.text = profileResponseModel.contact ?? "";
    isTwoFactorEnabled = profileResponseModel.twoFactor ?? false;
    update();
  }
}
