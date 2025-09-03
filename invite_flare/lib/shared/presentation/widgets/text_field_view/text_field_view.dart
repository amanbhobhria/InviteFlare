import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';

class TextFieldView extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? hindText;

  const TextFieldView({
    super.key,
    required this.controller,
    this.hindText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) => IFTextField(
        key: key,
        controller: controller,
        hintText: 'Email Address',
        textInputType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
      );
}
