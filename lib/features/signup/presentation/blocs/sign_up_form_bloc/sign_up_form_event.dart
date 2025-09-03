part of 'sign_up_form_bloc.dart';

sealed class SignUpFormEvent extends Equatable {
  const SignUpFormEvent();
}

final class SignUpSubmitEvent extends SignUpFormEvent {
  final String name;
  final String email;
  final String password;

  const SignUpSubmitEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        password,
      ];
}
