import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app_constants/screen_constants.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/shared/presentation/presentation.dart';

class SocialMediaWrapper extends StatelessWidget {
  const SocialMediaWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<SocialMediaBloc>(),
        child: const _SocialMediaWrapper(),
      );
}

class _SocialMediaWrapper extends StatelessWidget with ScreenConstants {
  const _SocialMediaWrapper();

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<SocialMediaBloc, SocialMediaState>(
        listener: (context, state) {
          if (state is SocialMediaError) {}
        },
        builder: (context, state) => SocialMediaView(
          onTapFacebookSignIn: () => context.read<SocialMediaBloc>().add(
                const SocialMediaSubmit(
                  socialMediaType: SocialMediaType.FACEBOOK,
                ),
              ),
          onTapGoogleSignIn: () => context.read<SocialMediaBloc>().add(
                const SocialMediaSubmit(
                  socialMediaType: SocialMediaType.GOOGLE,
                ),
              ),
        ),
      );
}
