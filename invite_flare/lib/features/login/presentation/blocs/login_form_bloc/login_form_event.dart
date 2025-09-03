part of 'login_form_bloc.dart';

sealed class LoginFormEvent extends Equatable {
  const LoginFormEvent();
}

final class SubmitLoginEvent extends LoginFormEvent {
  final String emailAddress;
  final String password;

  const SubmitLoginEvent({
    required this.emailAddress,
    required this.password,
  });
  @override
  List<Object?> get props => [emailAddress, password];
}
