import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:invite_flare/features/login/presentation/presentation.dart';

@RoutePage()
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) => const LoginPageWrapper();
}
