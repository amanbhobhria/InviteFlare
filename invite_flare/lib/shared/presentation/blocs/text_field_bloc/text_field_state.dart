part of 'text_field_bloc.dart';

sealed class TextFieldState extends Equatable {
  const TextFieldState();
}

final class TextFieldInitial extends TextFieldState {
  @override
  List<Object> get props => [];
}

final class TextFieldValid extends TextFieldState {
  @override
  List<Object> get props => [];
}

final class TextFieldCheck extends TextFieldState {
  @override
  List<Object> get props => [];
}

final class TextFieldError extends TextFieldState {
  final String? message;

  const TextFieldError({required this.message});

  @override
  List<Object> get props => [];
}
