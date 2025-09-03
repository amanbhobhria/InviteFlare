import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/base/base_stateless_widget.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/login/presentation/presentation.dart';
import 'package:invite_flare/shared/presentation/presentation.dart';

class LoginFormWrapper extends StatelessWidget {
  const LoginFormWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<LoginFormBloc>(),
        child: _LoginFormWrapper(),
      );
}

class _LoginFormWrapper extends BaseStatelessWidget {
  final TextEditingController emailCtrl =
      TextEditingController(text: 'gauravnarulain@gmail.com');
  final TextEditingController passwordCtrl =
      TextEditingController(text: 'Sham@123');

  @override
  Widget buildWidget(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const IFSpace(
            space: IFSpaces.xxxxxxL,
          ),
          IFHeading(
            text: loginTxt,
            headingSize: IFHeadingSize.xxxxxxL,
            textWeight: IFTextWeight.regular,
          ),
          IFText(
            text: welcomeBackTxt,
            textSize: IFTextSize.S,
          ),
          const IFSpace(
            space: IFSpaces.xxxxL,
          ),
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
            space: IFSpaces.xxxS,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {
                print('Cotrfef');
                print(emailCtrl.text);
                print(passwordCtrl.text);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IFText(
                  text: forgotPasswordBtnTxt,
                  textSize: IFTextSize.S,
                  textColor: IFTextColors.BRAND,
                ),
              ),
            ),
          ),
          const IFSpace(
            space: IFSpaces.L,
          ),
          BlocConsumer<LoginFormBloc, LoginFormState>(
            listener: (ctx, state) {
              if (state is LoginFormSuccess) {
                context.router.pushAndPopUntil(
                  const MainRoute(),
                  predicate: (route) => false,
                );
              } else if (state is LoginFormError) {
                LoginDialogs.showErrorDialog(
                  context: context,
                  title: 'Login Failed',
                  subTitle: state.message,
                );
              }
            },
            builder: (context, state) => IFButton(
              text: 'Continue',
              onPressed: () => context.read<LoginFormBloc>().add(
                  SubmitLoginEvent(
                      emailAddress: emailCtrl.text.trim(),
                      password: passwordCtrl.text.trim())),
              isLoading: state is LoginFormLoading,
            ),
          ),
        ],
      );
}
