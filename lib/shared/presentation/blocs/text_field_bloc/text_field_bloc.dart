import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/app/app.dart';

part 'text_field_event.dart';

part 'text_field_state.dart';

@injectable
class TextFieldBloc extends Bloc<TextFieldEvent, TextFieldState> {
  TextFieldBloc() : super(TextFieldInitial()) {
    on<TextFieldValidate>(validateText);
  }

  FutureOr<void> validateText(
    TextFieldValidate event,
    Emitter<TextFieldState> emitter,
  ) {
    emitter(TextFieldCheck());
    switch (event.textFieldType) {
      case TextFieldType.EMAIL:
        if (event.value.emailValidationMessage.isEmpty) {
          emitter(TextFieldValid());
        } else {
          emitter(
            TextFieldError(
              message: event.value.emailValidationMessage,
            ),
          );
        }
      case TextFieldType.PASSWORD:
        if (event.value.passwordValidationMessage == null) {
          emitter(TextFieldValid());
        } else {
          emitter(
            TextFieldError(
              message: event.value.passwordValidationMessage,
            ),
          );
        }
      case TextFieldType.PHONE:
      case TextFieldType.TEXT:
        if (event.value.otherValidationMessage(event.value).isEmpty) {
          emitter(TextFieldValid());
        } else {
          emitter(
            TextFieldError(
              message: event.value.otherValidationMessage(event.label ?? ''),
            ),
          );
        }
      case TextFieldType.OTHERS:
        if (event.value.otherValidationMessage(event.value).isEmpty) {
          emitter(TextFieldValid());
        } else {
          emitter(
            TextFieldError(
              message: event.value.otherValidationMessage(event.label ?? ''),
            ),
          );
        }
      case TextFieldType.INTEGER:
        if (event.value.integerValidationMessage(event.value).isEmpty) {
          emitter(TextFieldValid());
        } else {
          emitter(
            TextFieldError(
              message: event.value.integerValidationMessage(event.label ?? ''),
            ),
          );
        }
    }
  }
}
