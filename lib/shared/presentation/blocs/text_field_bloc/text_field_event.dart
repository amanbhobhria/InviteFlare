part of 'text_field_bloc.dart';

sealed class TextFieldEvent extends Equatable {
  const TextFieldEvent();
}

final class TextFieldValidate extends TextFieldEvent {
  final String value;
  final TextFieldType textFieldType;
  final String? label;

  const TextFieldValidate({
    required this.value,
    required this.textFieldType,
    this.label,
  });
  @override
  List<Object?> get props => [value, textFieldType, label];
}
