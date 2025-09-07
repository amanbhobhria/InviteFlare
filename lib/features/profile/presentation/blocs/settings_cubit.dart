import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsState {
  final bool removeAllSessions;
  final List<Map<String, dynamic>> notifications;

  SettingsState({
    required this.removeAllSessions,
    required this.notifications,
  });

  SettingsState copyWith({
    bool? removeAllSessions,
    List<Map<String, dynamic>>? notifications,
  }) {
    return SettingsState(
      removeAllSessions: removeAllSessions ?? this.removeAllSessions,
      notifications: notifications ?? this.notifications,
    );
  }
}

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
      : super(SettingsState(removeAllSessions: false, notifications: [
    {
      "title": "Event Updates",
      "subtitle": "Get notified about upcoming events",
      "enabled": true,
    },
    {
      "title": "Promotions",
      "subtitle": "Receive offers and discounts",
      "enabled": false,
    },
    {
      "title": "Reminders",
      "subtitle": "Daily reminders for events",
      "enabled": true,
    },
    {
      "title": "Newsletter",
      "subtitle": "Monthly news and tips",
      "enabled": false,
    },
  ]));

  void toggleNotification(int index, bool value) {
    final updated = [...state.notifications];
    updated[index]["enabled"] = value;
    emit(state.copyWith(notifications: updated));
  }

  void toggleRemoveAllSessions(bool value) {
    emit(state.copyWith(removeAllSessions: value));
  }
}
