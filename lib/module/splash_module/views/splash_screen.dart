// ignore_for_file: prefer_expression_function_bodies

import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/splash_module/controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  final controller = Get.put(SplashController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(
        init: controller,
        builder: (controller) {
          return Scaffold(
            body: SizedBox(
              width: context.width,
              height: context.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/png/AppLogo.png',
                    width: 300,
                  ),
                  const IFSpace(
                    space: IFSpaces.xxxxL,
                  ),
                  const CircularProgressIndicator(
                    strokeWidth: 2,
                  )
                ],
              ),
            ),
          );
        });
  }
}
