import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:invite_flare/features/signup/presentation/pages/sign_up_wrapper.dart';

@RoutePage()
class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) => const SignUpWrapper();
}
