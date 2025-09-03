import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/di/di.dart';

class AppRoot extends StatelessWidget {
  AppRoot({super.key});

  final _appRouter = getIt<AppRouter>();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        title: 'InviteFlare',
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: IFColors.BRAND),
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: IFColors.BRAND,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 1),
            appBarTheme: const AppBarTheme(
              surfaceTintColor: Colors.white,
              backgroundColor: Colors.white,
            )),
      );
}
