/*
 * @copyright : Ozvid Technologies Pvt. Ltd. < www.ozvid.com >
 * @author     : Shiv Charan Panjeta < shiv@ozvid.com >
 * All Rights Reserved.
 * Proprietary and confidential :  All information contained herein is, and remains
 * the property of Ozvid Technologies Pvt. Ltd. and its partners.
 * Unauthorized copying of this file, via any medium is strictly prohibited.
 */

import 'package:invite_flare/features/profile/presentation/pages/settings_page.dart';
import 'package:invite_flare/module/card/card/views/card_detail_screen.dart';
import 'package:invite_flare/module/profile/binding/profile_binding.dart';
import 'package:invite_flare/module/profile/views/profile_screen.dart';
import 'package:invite_flare/module/profile/views/setting_screen.dart';
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
    GetPage(
      name: AppRoutes.profileScreen,
      page: () => ProfileScreen(),
      bindings: [ProfileBinding()],
    ),
    GetPage(
      name: AppRoutes.settingScreen,
      page: () => SettingScreen(),
      bindings: [ProfileBinding()],
    ),
    GetPage(
      name: AppRoutes.cardDetailScreen,
      page: () => CardDetailScreen(),
    ),
  ];
}
