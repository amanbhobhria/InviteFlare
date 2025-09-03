import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/features/login/data/data.dart';

part 'login_form_event.dart';
part 'login_form_state.dart';

@injectable
class LoginFormBloc extends Bloc<LoginFormEvent, LoginFormState> {
  final LoginRepository _loginRepository;

  LoginFormBloc({required LoginRepository loginRepository})
      : _loginRepository = loginRepository,
        super(LoginFormInitial()) {
    on<SubmitLoginEvent>(submitLoginForm);
  }

  FutureOr<void> submitLoginForm(
    SubmitLoginEvent event,
    Emitter<LoginFormState> emit,
  ) async {
    emit(LoginFormLoading());

    if (event.emailAddress.isValidEmail &&
        event.password.passwordValidationMessage == null) {
      try {
        final body = {'email': event.emailAddress, 'password': event.password};

        final response = await _loginRepository.loginUser(body);
        final decodedJson = jsonDecode(response.body);
        final tokenService = TokenService();
        await tokenService.saveAccessToken(decodedJson['data']['access_token']);
        await tokenService
            .saveRefreshToken(decodedJson['data']['refresh_token']);
        await tokenService.saveSession(isLoggedIn: true);
        if (response.statusCode == 200) {
          emit(LoginFormSuccess());
        } else {
          emit(
            LoginFormError(message: decodedJson['message']),
          );
        }
      } catch (e) {
        emit(LoginFormError(message: e.toString()));
      }
    } else {
      emit(
        const LoginFormError(
            message: 'Invalid email or password. Please try again.'),
      );
    }
  }
}
