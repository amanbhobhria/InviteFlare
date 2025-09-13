/*
 * @copyright : ToXSL Technologies Pvt. Ltd. < www.toxsl.com >
 * @author     : Shiv Charan Panjeta < shiv@toxsl.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of ToXSL Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:device_info_plus/device_info_plus.dart';
import 'package:invite_flare/core_2/core/widgets/custom_loader.dart';
import 'package:invite_flare/core_2/data/remote_service/entity/request_model/auth_reuest_model.dart';
import 'package:invite_flare/core_2/data/remote_service/network/endpoint.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../export.dart';
import 'dio_client.dart';

class APIRepository {
  static late DioClient? dioClient;
  static var deviceName, deviceType, deviceID, deviceVersion;

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(baseUrl, dio);
    getDeviceData();
  }

  getDeviceData() async {
    DeviceInfoPlugin info = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await info.androidInfo;
      deviceName = androidDeviceInfo.model;
      deviceID = androidDeviceInfo.id;
      deviceVersion = androidDeviceInfo.version.release;
      deviceType = "1";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await info.iosInfo;
      deviceName = iosDeviceInfo.model;
      deviceID = iosDeviceInfo.identifierForVendor;
      deviceVersion = iosDeviceInfo.systemVersion;
      deviceType = "2";
    }
  }
  // Future registerWithEmailAndPassword(String email, String password, String firstName, String lastName) async {
  //   try {
  //     UserCredential userCredential = await auth.createUserWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     // await userCredential.user!.updateDisplayName(firstName + " " + lastName);
  //     // userCredential.user!.sendEmailVerification();
  //     return userCredential;
  //   } on FirebaseAuthException catch (e) {
  //     debugPrint('Error---------${e.stackTrace}');
  //     debugPrint('stack--------${e.code}');
  //     return e.code == "firebaseAlreadyEmailExist" ? e.code.replaceFirst(e.code, "UserEmailExist") : e.code;
  //   }
  // }

  reportCrash(stackTrace) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    CustomLoader customLoader = CustomLoader();
    var req = AuthRequestModel.logCrashErrorReq(
        error: packageInfo.packageName, packageVersion: version, phoneModel: APIRepository.deviceName, ip: APIRepository.deviceVersion, stackTrace: stackTrace);
    debugPrint('Log req: $req', wrapWidth: 1000);
    // await APIRepository.reportCrashLogApiCall(data: req).then((value) async {
    //   customLoader.hide();
    //   if (value != null) {}
    // }).onError((error, stackTrace) {
    //   customLoader.hide();
    //   initApp();
    //   toast(error.toString());
    // });
  }
}
