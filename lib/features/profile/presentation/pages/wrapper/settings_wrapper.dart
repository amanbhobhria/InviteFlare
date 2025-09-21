import 'package:flutter/material.dart';
import 'package:invite_flare/features/profile/presentation/pages/settings_sections.dart';

// class SettingsWrapper extends StatelessWidget {
//   const SettingsWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Account Settings"),
//       ),
//       body: const SettingsSections(),
//     );
//   }
// }
//
// import 'package:flutter/material.dart';
// import '../widgets/settings_sections.dart';

class SettingsWrapper extends StatelessWidget {
  final bool fromBottomNav;

  const SettingsWrapper({super.key, this.fromBottomNav = false});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Account Settings"),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            bottom: fromBottomNav ? kBottomNavigationBarHeight + 16 : 16,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: const SettingsSections(),
        ),
      );
}
