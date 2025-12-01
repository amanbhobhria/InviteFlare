// ignore_for_file: prefer_expression_function_bodies

import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core_2/core/values/app_colors.dart';
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
                    // 'assets/images/png/AppLogo.png',
                    'assets/images/png/app_logo.png',
                    width: 206,
                    height: 109,
                  ),
                  const IFSpace(
                    space: IFSpaces.xxxxL,
                  ),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Invitation",
                          style: TextStyle(
                            fontFamily: "Limelight",          // Limelight font
                            fontSize: 28,
                            fontStyle: FontStyle.italic,
                            color: Color(0xFF18A281),
                          ),
                        ),
                        TextSpan(
                          text: "kart",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,               // black color
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),


                  // const CircularProgressIndicator(
                  //   strokeWidth: 2,
                  // )
                ],
              ),
            ),
          );
        });
  }
}
