part of 'sign_up_form_bloc.dart';

sealed class SignUpFormState extends Equatable {
  const SignUpFormState();
}

final class SignUpFormInitial extends SignUpFormState {
  @override
  List<Object> get props => [];
}

final class SignUpFormLoading extends SignUpFormState {
  @override
  List<Object> get props => [];
}

final class SignUpFormError extends SignUpFormState {
  final String message;

  const SignUpFormError({required this.message});
  @override
  List<Object> get props => [message];
}

final class SignUpFormSuccess extends SignUpFormState {
  @override
  List<Object> get props => [];
}
