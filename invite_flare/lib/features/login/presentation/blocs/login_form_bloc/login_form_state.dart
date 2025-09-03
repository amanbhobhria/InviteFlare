part of 'login_form_bloc.dart';

sealed class LoginFormState extends Equatable {
  const LoginFormState();
}

final class LoginFormInitial extends LoginFormState {
  @override
  List<Object> get props => [];
}

final class LoginFormLoading extends LoginFormState {
  @override
  List<Object> get props => [];
}

final class LoginFormSuccess extends LoginFormState {
  @override
  List<Object> get props => [];
}

final class LoginFormError extends LoginFormState {
  final String message;

  const LoginFormError({required this.message});

  @override
  List<Object> get props => [message];
}
