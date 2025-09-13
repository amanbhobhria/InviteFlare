/*
 * @copyright : Ozvid Technologies Pvt. Ltd. < www.ozvid.com >
 * @author     : Shiv Charan Panjeta < shiv@ozvid.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Ozvid Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */



import 'package:invite_flare/module/splash_module/binding/splash_binding.dart';
import 'package:invite_flare/module/splash_module/views/splash_screen.dart';

import '../../export.dart';


// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = AppRoutes.splash;
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      bindings: [SplashBinding()],
    ),
    
  ];
}
