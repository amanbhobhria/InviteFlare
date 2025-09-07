import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/features/profile/presentation/blocs/settings_cubit.dart';
import 'package:invite_flare/features/profile/presentation/pages/wrapper/settings_wrapper.dart';





class SettingsPage extends StatelessWidget {
  final bool fromBottomNav; // ✅ new flag

  const SettingsPage({super.key, this.fromBottomNav = false});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => SettingsCubit(),
      child: SettingsWrapper(fromBottomNav: fromBottomNav),
    );
}
