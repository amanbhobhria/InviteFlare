import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/module/profile/controller/setting_controller.dart';

class SettingScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

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
            child: Obx(
              () => Column(
                children: [
                  ...controller.notifications.asMap().entries.map((entry) {
                    int index = entry.key;
                    var item = entry.value;
                    return SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: appColor,
                      title: Text(item["title"]),
                      subtitle: Text(item["subtitle"]),
                      value: item["enabled"],
                      onChanged: (val) {
                        controller.toggleNotification(index, val);
                      },
                    );
                  }).toList(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Notifications saved")),
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
                TextField(
                  controller: controller.oldPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Old Password *",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller.newPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "New Password *",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller.confirmPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password *",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Obx(
                  () => SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    activeColor: appColor,
                    title: const Text("Remove all sessions"),
                    subtitle: const Text("Logout from all devices"),
                    value: controller.removeAllSessions.value,
                    // activeThumbColor: Colors.blue,
                    trackColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.blue.withOpacity(0.5);
                        }
                        return Colors.grey.withOpacity(0.5);
                      },
                    ),
                    onChanged: (val) {
                      controller.toggleRemoveAllSessions(val);
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
                      controller.callChangePasswordApi();
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
                TextField(
                  controller: controller.emailTextController,
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
                      print('Check Datatttatata---------');
                      controller.callDeleteAccountApi();
                      print('Check Datatttatata1111111111111---------');
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
  Widget _buildSection({required String title, required Widget child}) {
    return Container(
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
}
