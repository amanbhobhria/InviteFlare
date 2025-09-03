import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/shared/presentation/blocs/blocs.dart';

class TextFieldWrapper extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final String? errorText;
  final TextInputType? textInputType;
  final TextFieldType textFieldType;
  final TextInputAction? textInputAction;
  final bool isRequired;
  final Function()? onTap;

  const TextFieldWrapper({
    super.key,
    required this.controller,
    required this.textFieldType,
    this.isRequired = false,
    this.onTap,
    this.hintText,
    this.errorText,
    this.textInputType,
    this.textInputAction,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<TextFieldBloc>(),
        child: _TextFieldWrapper(
          controller: controller,
          hintText: hintText,
          textFieldType: textFieldType,
          textInputAction: textInputAction,
          textInputType: textInputType,
          obscureText: obscureText,
          onTap: onTap,
          isRequired: isRequired,
        ),
      );
}

class _TextFieldWrapper extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String? hintText;
  final TextFieldType textFieldType;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function()? onTap;
  final bool isRequired;

  const _TextFieldWrapper({
    required this.controller,
    required this.textFieldType,
    this.isRequired = false,
    this.onTap,
    this.hintText,
    this.textInputType,
    this.textInputAction,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<TextFieldBloc, TextFieldState>(
        builder: (context, state) => IFTextField(
          controller: controller,
          hintText: "$hintText ${isRequired ? "" : "(optional)"}",
          textInputType: textInputType,
          textInputAction: textInputAction,
          onTap: onTap,
          onChanged: (v) {
            context.read<TextFieldBloc>().add(
                  TextFieldValidate(
                    value: v,
                    textFieldType: textFieldType,
                    label: hintText,
                  ),
                );
          },
          obscureText: obscureText,
          errorText: isRequired
              ? state is TextFieldError
                  ? state.message
                  : null
              : null,
        ),
      );
}
