import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/splash/presentation/presentation.dart';

class SplashPageWrapper extends StatelessWidget {
  const SplashPageWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<SplashBloc>()..add(FetchDataEvent()),
        child: const _SplashPageWrapper(),
      );
}

class _SplashPageWrapper extends StatelessWidget {
  const _SplashPageWrapper();

  @override
  Widget build(BuildContext context) => BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccessState) {
            context.router.pushAndPopUntil(
              const LoginRoute(),
              predicate: (Route<dynamic> route) => false,
            );
          } else if (state is SplashHomeState) {
            context.router.pushAndPopUntil(
              const MainRoute(),
              predicate: (Route<dynamic> route) => false,
            );
          }
        },
        builder: (ctx, state) => const SplashView(),
      );
}
