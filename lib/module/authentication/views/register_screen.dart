import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app_constants/screen_constants.dart';
import 'package:invite_flare/module/authentication/controller/register_controller.dart';
import 'package:invite_flare/shared/presentation/pages/wrapper/text_field_wrapper/text_field_wrapper.dart';

class RegisterScreen extends StatelessWidget with ScreenConstants {

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IFSpace(space: IFSpaces.xxxxxxL),
            IFHeading(
              text: signUpBtnTxt,
              headingSize: IFHeadingSize.xxxxxxL,
              textWeight: IFTextWeight.regular,
            ),
            IFText(text: signUpGetStart, textSize: IFTextSize.S),
            const IFSpace(space: IFSpaces.xxxxL),

            // Full Name
            TextFieldWrapper(
              controller: controller.nameController,
              hintText: fullNameTxt,
              isRequired: true,
              textFieldType: TextFieldType.TEXT,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
            ),
            const IFSpace(),

            // Email
            TextFieldWrapper(
              controller: controller.emailController,
              hintText: emailAddressHintTxt,
              isRequired: true,
              textFieldType: TextFieldType.EMAIL,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
            ),
            const IFSpace(),

            // Password
            TextFieldWrapper(
              controller: controller.passwordController,
              textFieldType: TextFieldType.PASSWORD,
              hintText: passwordHintTxt,
              isRequired: true,
              obscureText: true,
              textInputAction: TextInputAction.done,
              textInputType: TextInputType.text,
            ),
            const IFSpace(space: IFSpaces.xxxxL),

            // Signup Button
            Obx(
              () => IFButton(
                text: signUpBtnTxt,
                onPressed: controller.callSignUpApi,
                isLoading: controller.isLoading.value,
              ),
            ),

            const IFSpace(space: IFSpaces.xxxL),

            // Login redirect
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IFText(text: alreadyHaveAccount, textSize: IFTextSize.S),
                InkWell(
                  onTap: () => Get.back(),
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
    );
  }
}
