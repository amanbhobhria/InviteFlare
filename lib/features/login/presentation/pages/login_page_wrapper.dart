import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/app/navigation/app_router.dart';
import 'package:invite_flare/core/base/base_stateless_widget.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/features/login/login.dart';
import 'package:invite_flare/features/signup/presentation/pages/pages.dart';
import 'package:invite_flare/shared/presentation/presentation.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) => _LoginPageWrapper();
}

class _LoginPageWrapper extends BaseStatelessWidget {
  @override
  Widget buildWidget(BuildContext context) => Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginFormWrapper(),
                const IFSpace(
                  space: IFSpaces.xxxxxL,
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
                  space: IFSpaces.xxxxxL,
                ),
                const SocialMediaWrapper(),
                const IFSpace(
                  space: IFSpaces.xxxL,
                ),
                IFText(
                  text: termOfServiceTxt,
                  textSize: IFTextSize.xS,
                  textAlign: TextAlign.center,
                  textColor: IFTextColors.DESCRIPTION,
                ),
                const IFSpace(
                  space: IFSpaces.xxxxL,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      Get.context!,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IFText(
                        text: doNotHaveAccount,
                        textSize: IFTextSize.S,
                      ),
                      InkWell(
                        onTap: () {
                          context.router.push(const SignUpRoute());
                        },
                        child: IFText(
                          text: signUpBtnTxt,
                          textSize: IFTextSize.S,
                          textWeight: IFTextWeight.semiBold,
                          textColor: IFTextColors.BRAND,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
