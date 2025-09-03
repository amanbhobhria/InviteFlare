import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app_constants/screen_constants.dart';

class SocialMediaView extends StatelessWidget with ScreenConstants {
  final Function() onTapGoogleSignIn;
  final Function() onTapFacebookSignIn;

  const SocialMediaView({
    super.key,
    required this.onTapGoogleSignIn,
    required this.onTapFacebookSignIn,
  });

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IFButton(
            text: facebookBtnTxt,
            onPressed: () => onTapFacebookSignIn,
            buttonType: IFButtonType.FACEBOOK,
          ),
          const IFSpace(),
          IFButton(
            text: googleBtnTxt,
            onPressed: () => onTapGoogleSignIn,
            buttonType: IFButtonType.GOOGLE,
          ),
        ],
      );
}
