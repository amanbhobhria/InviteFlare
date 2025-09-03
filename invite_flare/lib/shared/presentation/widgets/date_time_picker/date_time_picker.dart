import 'package:flutter/material.dart';

mixin DateTimePicker {
  static Future<DateTime?> datePicker(
          {required BuildContext context,
          DateTime? initialDate,
          DatePickerMode? initialDatePickerMode,
          required String helpText}) async =>
      await showDatePicker(
        context: context,
        initialDate: initialDate ?? DateTime.now(),
        firstDate: DateTime(1970),
        lastDate: DateTime(DateTime.now().year + 1),
        helpText: helpText,
        confirmText: 'Confirm',
      );
  static Future<DateTime?> dateTimePicker(
      {required BuildContext context,
      DateTime? initialDate,
      DatePickerMode? initialDatePickerMode,
      required String helpText}) async {
    DateTime? selectedDateTime;
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(DateTime.now().year + 1),
      helpText: helpText,
      confirmText: 'Confirm',
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        final DateTime combinedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        return combinedDateTime;
      }
    }
    return null;
  }
}
