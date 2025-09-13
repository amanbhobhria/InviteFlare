import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/extensions/extensions.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
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


}
