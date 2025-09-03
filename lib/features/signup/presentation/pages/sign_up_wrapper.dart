import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app_constants/screen_constants.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/features/signup/presentation/pages/pages.dart';
import 'package:invite_flare/shared/presentation/pages/pages.dart';

class SignUpWrapper extends StatelessWidget {
  const SignUpWrapper({super.key});

  @override
  Widget build(BuildContext context) => const _SignUpWrapper();
}

class _SignUpWrapper extends StatelessWidget with ScreenConstants {
  const _SignUpWrapper();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SignUpFormWrapper(),
                const IFSpace(
                  space: IFSpaces.xxxL,
                ),
                const Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Divider(),
                      ),
                    ),
                    IFText(
                      text: 'OR',
                      textSize: IFTextSize.S,
                      textWeight: IFTextWeight.semiBold,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Divider(),
                      ),
                    ),
                  ],
                ),
                const IFSpace(
                  space: IFSpaces.xxxL,
                ),
                const SocialMediaWrapper(),
                const IFSpace(
                  space: IFSpaces.xxxxxL,
                ),
                const IFSpace(
                  space: IFSpaces.xxxxL,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IFText(
                      text: alreadyHaveAccount,
                      textSize: IFTextSize.S,
                    ),
                    InkWell(
                      onTap: () {
                        context.router.popForced();
                      },
                      child: IFText(
                        text: loginTxt,
                        textSize: IFTextSize.S,
                        textWeight: IFTextWeight.semiBold,
                        textColor: IFTextColors.BRAND,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
