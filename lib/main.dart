// import 'package:flutter/material.dart';
// import 'package:invite_flare/app/app.dart';
// import 'package:invite_flare/core/di/di.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   configureDependencyInjection('env');
//   SystemUiHandler.setLightTheme();
//   runApp(AppRoot());
// }

import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/app/system_ui_handler/system_ui_handler.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/core_2/core/translations/translation_service.dart';
import 'package:invite_flare/core_2/core/values/app_theme.dart';
import 'package:invite_flare/core_2/core/widgets/custom_loader.dart';
import 'package:invite_flare/core_2/data/local_service/preference/preference_manager.dart';
import 'package:invite_flare/core_2/data/remote_service/network/api_provider.dart';
import 'package:invite_flare/core_2/logger/logger_utils.dart';
import 'package:invite_flare/core_2/routes/app_pages.dart';


import 'package:invite_flare/module/splash_module/binding/splash_binding.dart';
import 'package:logger/logger.dart';

import 'export.dart';

var randomNumber;
var log = Logger();
GetStorage storage = GetStorage();
CustomLoader customLoader = CustomLoader();
TextTheme textTheme = Theme.of(Get.context!).textTheme;
var tempDir;
FirebaseFirestore databaseReference = FirebaseFirestore.instance;
// late final APIRepository repository;
late final PreferenceManger preferenceManger;
var deviceToken;

Future<void> main() async {
  // initializationFunction();
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencyInjection('env');
  SystemUiHandler.setLightTheme();
  orientation();
  initApp();
  crashesCheck();
}

orientation() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light,
  );
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.dark));
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

initApp() async {
  runApp(const MyApp());
}

crashesCheck() async {
  tempDir = await getTemporaryDirectory();
  PlatformDispatcher.instance.onError = (error, stack) {
    // reportCrash('$error\n$stack');
    return true;
  };
  FlutterError.onError = (details) async {
    if (details.stack != null) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      // reportCrash('${details.exception}\n${details.stack}');
    } else {
      FlutterError.presentError(details);
    }
  };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: ScreenUtilInit(
        builder: (context, widget) => GetMaterialApp(
          theme: ThemeConfig.lightTheme,
          initialBinding: SplashBinding(),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          scaffoldMessengerKey: GlobalVariable.navState,
          debugShowCheckedModeBanner: false,
          enableLog: true,
          logWriterCallback: LoggerX.write,
          locale: TranslationService.locale,
          fallbackLocale: TranslationService.fallbackLocale,
          translations: TranslationService(),
          // localizationsDelegates: ,
          builder: EasyLoading.init(),
          // defaultTransition: Transition.cupertino,


        ),
      ),
    );
  }
}

class GlobalVariable {
  static final GlobalKey<ScaffoldMessengerState> navState =
      GlobalKey<ScaffoldMessengerState>();

  static final GlobalKey<NavigatorState> navigatorState =
      GlobalKey<NavigatorState>();
}
