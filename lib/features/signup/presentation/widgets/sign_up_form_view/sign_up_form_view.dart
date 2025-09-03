import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base_stateless_widget.dart';

import 'package:invite_flare/shared/presentation/presentation.dart';

class SignUpFormView extends BaseStatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final void Function()? onPressSubmit;
  final bool isLoading;

  const SignUpFormView({
    super.key,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.onPressSubmit,
    required this.isLoading,
  });

  @override
  Widget buildWidget(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const IFSpace(
            space: IFSpaces.xxxxxxL,
          ),
          IFHeading(
            text: signUpBtnTxt,
            headingSize: IFHeadingSize.xxxxxxL,
            textWeight: IFTextWeight.regular,
          ),
          IFText(
            text: signUpGetStart,
            textSize: IFTextSize.S,
          ),
          const IFSpace(
            space: IFSpaces.xxxxL,
          ),
          TextFieldWrapper(
            controller: nameCtrl,
            hintText: fullNameTxt,
            isRequired: true,
            textFieldType: TextFieldType.TEXT,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.name,
          ),
          const IFSpace(),
          TextFieldWrapper(
            controller: emailCtrl,
            hintText: emailAddressHintTxt,
            isRequired: true,
            textFieldType: TextFieldType.EMAIL,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
          ),
          const IFSpace(),
          TextFieldWrapper(
            controller: passwordCtrl,
            textFieldType: TextFieldType.PASSWORD,
            hintText: passwordHintTxt,
            isRequired: true,
            obscureText: true,
            textInputAction: TextInputAction.done,
            textInputType: TextInputType.text,
          ),
          const IFSpace(
            space: IFSpaces.xxxxL,
          ),
          IFButton(
            text: signUpBtnTxt,
            onPressed: onPressSubmit,
            isLoading: isLoading,
          ),
        ],
      );
}
