import 'package:flutter/material.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/di/di.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // configureDependencyInjection('env');
  configureDependencyInjection('');

  SystemUiHandler.setLightTheme();
  runApp(AppRoot());
}
