import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/features/profile/presentation/blocs/settings_cubit.dart';


class SettingsSections extends StatelessWidget {
  const SettingsSections({super.key});

  @override
  Widget build(BuildContext context) {
    final appColor = Theme.of(context).primaryColor;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Notifications Section
          _buildSection(
            title: "Email Notification Settings",
            child: BlocBuilder<SettingsCubit, SettingsState>(
              builder: (context, state) => Column(
                  children: [
                    ...state.notifications.asMap().entries.map(
                          (entry) {
                        int index = entry.key;
                        var item = entry.value;
                        return SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: appColor,
                          title: Text(item["title"]),
                          subtitle: Text(item["subtitle"]),
                          value: item["enabled"],
                          onChanged: (val) {
                            context
                                .read<SettingsCubit>()
                                .toggleNotification(index, val);
                          },
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Notifications saved")),
                          );
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
            ),
          ),
          const SizedBox(height: 16),

          // Change Password Section
          _buildSection(
            title: "Change Password",
            child: Column(
              children: [
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Old Password *",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "New Password *",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password *",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                BlocBuilder<SettingsCubit, SettingsState>(
                  builder: (context, state) => SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: appColor,
                      title: const Text("Remove all sessions"),
                      subtitle: const Text("Logout from all devices"),
                      value: state.removeAllSessions,
                      onChanged: (val) {
                        context
                            .read<SettingsCubit>()
                            .toggleRemoveAllSessions(val);
                      },
                    ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Password updated")),
                      );
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Delete Account Section
          _buildSection(
            title: "Delete Account",
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Email Address *",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Delete account requested")),
                      );
                    },
                    child: const Text("Delete"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper section box
  Widget _buildSection({required String title, required Widget child}) => Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          const Divider(),
          child,
        ],
      ),
    );
}
