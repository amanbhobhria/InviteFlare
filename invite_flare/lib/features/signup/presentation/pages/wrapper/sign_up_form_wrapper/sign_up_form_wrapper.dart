import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/base/base_stateless_widget.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/signup/presentation/presentation.dart';

class SignUpFormWrapper extends StatelessWidget {
  const SignUpFormWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<SignUpFormBloc>(),
        child: _SignUpFormWrapper(),
      );
}

class _SignUpFormWrapper extends BaseStatelessWidget {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget buildWidget(BuildContext context) =>
      BlocConsumer<SignUpFormBloc, SignUpFormState>(
        listener: (ctx, state) {
          if (state is SignUpFormError) {
            SignUpDialogs.showErrorDialog(
              context: context,
              title: signUpFailedTxt,
              subTitle: state.message,
            );
          } else if (state is SignUpFormSuccess) {
            context.router.pushAndPopUntil(
              const MainRoute(),
              predicate: (route) => false,
            );
          }
        },
        builder: (context, state) => SignUpFormView(
          emailCtrl: emailCtrl,
          passwordCtrl: passwordCtrl,
          nameCtrl: nameCtrl,
          onPressSubmit: () => context.read<SignUpFormBloc>().add(
                SignUpSubmitEvent(
                    name: nameCtrl.text.trim(),
                    email: emailCtrl.text.trim(),
                    password: passwordCtrl.text.trim()),
              ),
          isLoading: state is SignUpFormLoading,
        ),
      );
}
