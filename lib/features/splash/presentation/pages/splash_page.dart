import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/features/splash/presentation/pages/pages.dart';

@RoutePage()
class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SizedBox(
            width: context.width,
            height: context.height,
            child: const SplashPageWrapper()),
      );
}
