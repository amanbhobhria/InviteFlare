import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core_2/core/values/dimens.dart';
import 'package:invite_flare/module/authentication/controller/login_controller.dart';
import 'package:invite_flare/module/authentication/views/register_screen.dart';
import 'package:invite_flare/shared/presentation/pages/wrapper/social_media_wrapper/social_media_wrapper.dart';
import 'package:invite_flare/shared/presentation/pages/wrapper/text_field_wrapper/text_field_wrapper.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  // ignore: prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IFSpace(space: IFSpaces.xxxxxxL),
          const IFHeading(
            text: "Login",
            headingSize: IFHeadingSize.xxxxxxL,
            textWeight: IFTextWeight.regular,
          ),
          const IFText(
            text: "Welcome back",
            textSize: IFTextSize.S,
          ),
          const IFSpace(space: IFSpaces.xxxxL),

          // Email Field
          TextFieldWrapper(
            controller: controller.emailCtrl,
            hintText: "Email Address",
            isRequired: true,
            textFieldType: TextFieldType.EMAIL,
            textInputAction: TextInputAction.next,
            textInputType: TextInputType.emailAddress,
            // onChanged: (val) => controller.email.value = val,
          ),

          const IFSpace(),

          // Password Field
          TextFieldWrapper(
            controller: controller.passwordCtrl,
            hintText: "Password",
            textFieldType: TextFieldType.PASSWORD,
            obscureText: true,
            isRequired: true,
            // onChanged: (val) => controller.password.value = val,
          ),

          const IFSpace(space: IFSpaces.xxxS),

          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                print("Forgot Password");
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: IFText(
                  text: "Forgot Password?",
                  textSize: IFTextSize.S,
                  textColor: IFTextColors.BRAND,
                ),
              ),
            ),
          ),

          const IFSpace(space: IFSpaces.L),

          // ✅ GetX Button with Loading
          Obx(
            () => IFButton(
              text: controller.isLoading.value ? "Loading..." : "Continue",
              onPressed: () => controller.callLoginApi2(),
              isLoading: controller.isLoading.value,
            ),
          ),

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
            text:
                "By signing up, via Google, Facebook or email, I agree to InviteFlare Terms of Service and Privacy Policy.",
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
              // Navigator.pushAndRemoveUntil(
              //   Get.context!,
              //   MaterialPageRoute(builder: (context) => SignUpPage()),
              //   (Route<dynamic> route) => false,
              // );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IFText(
                  text: "Don't have an account? ",
                  textSize: IFTextSize.S,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => RegisterScreen());
                  },
                  child: IFText(
                    text: "Sign Up",
                    textSize: IFTextSize.S,
                    textWeight: IFTextWeight.semiBold,
                    textColor: IFTextColors.BRAND,
                  ),
                ),
              ],
            ),
          )
        ],
      ).marginSymmetric(horizontal: margin_20),
    );
  }
}
