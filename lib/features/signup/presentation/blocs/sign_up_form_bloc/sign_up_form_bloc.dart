import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/features/signup/data/data.dart';

part 'sign_up_form_event.dart';
part 'sign_up_form_state.dart';

@injectable
class SignUpFormBloc extends Bloc<SignUpFormEvent, SignUpFormState> {
  final SignUpRepository _signUpRepository;

  SignUpFormBloc({required SignUpRepository signUpRepository})
      : _signUpRepository = signUpRepository,
        super(SignUpFormInitial()) {
    on<SignUpSubmitEvent>(signUpSubmitMethod);
  }

  FutureOr<void> signUpSubmitMethod(
    SignUpSubmitEvent event,
    Emitter<SignUpFormState> emit,
  ) async {
    try {
      if (event.email.isValidEmail &&
          event.password.passwordValidationMessage == null &&
          event.name.isNotEmpty) {
        emit(SignUpFormLoading());
        final body = {
          'name': event.name,
          'email': event.email,
          'password': event.password
        };

        final response = await _signUpRepository.signUpUser(body);
        final decodedJson = jsonDecode(response.body);
        if (response.statusCode == 201) {
          emit(SignUpFormSuccess());
        } else {
          emit(SignUpFormError(message: decodedJson['message']));
        }
      } else {
        emit(const SignUpFormError(
            message: 'Please fill the registration form'));
      }
    } catch (e) {
      emit(SignUpFormError(message: e.toString()));
    }
  }
}
