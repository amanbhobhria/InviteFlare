import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/module/profile/controller/setting_controller.dart';



class SettingScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    final appColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "Settings",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // =================== Email Notifications ===================
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
                        title: Text(
                          item["title"],
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(item["subtitle"]),
                        value: item["enabled"],
                        onChanged: (val) =>
                            controller.toggleNotification(index, val),
                      );
                    }).toList(),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
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

            const SizedBox(height: 20),

            // =================== Change Password ===================
            _buildSection(
              title: "Change Password",
              child: Column(
                children: [
                  _buildTextField(
                    controller: controller.oldPassword,
                    label: "Old Password *",
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: controller.newPassword,
                    label: "New Password *",
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: controller.confirmPassword,
                    label: "Confirm Password *",
                    obscureText: true,
                  ),
                  const SizedBox(height: 12),
                  Obx(
                        () => SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: appColor,
                      title: const Text("Remove all sessions"),
                      subtitle: const Text("Logout from all devices"),
                      value: controller.removeAllSessions.value,
                      onChanged: (val) =>
                          controller.toggleRemoveAllSessions(val),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: appColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: () => controller.callChangePasswordApi(),
                      child: const Text("Save"),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // =================== Delete Account ===================
            _buildSection(
              title: "Delete Account",
              child: Column(
                children: [
                  _buildTextField(
                    controller: controller.emailTextController,
                    label: "Email Address *",
                    obscureText: false,
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: () => controller.callDeleteAccountApi(),
                      child: const Text("Delete"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =================== Section Builder ===================
  Widget _buildSection({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            spreadRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }

  // =================== TextField Builder ===================
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) => TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
}






// class SettingScreen extends StatelessWidget {
//   final SettingsController controller = Get.put(SettingsController());
//
//   @override
//   Widget build(BuildContext context) {
//     final appColor = Theme.of(context).primaryColor;
//
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         children: [
//           // Notifications Section
//           _buildSection(
//             title: "Email Notification Settings",
//             child: Obx(
//               () => Column(
//                 children: [
//                   ...controller.notifications.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     var item = entry.value;
//                     return SwitchListTile(
//                       contentPadding: EdgeInsets.zero,
//                       activeColor: appColor,
//                       title: Text(item["title"]),
//                       subtitle: Text(item["subtitle"]),
//                       value: item["enabled"],
//                       onChanged: (val) {
//                         controller.toggleNotification(index, val);
//                       },
//                     );
//                   }).toList(),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: appColor,
//                         foregroundColor: Colors.white,
//                       ),
//                       onPressed: () {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           const SnackBar(content: Text("Notifications saved")),
//                         );
//                       },
//                       child: const Text("Save"),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Change Password Section
//           _buildSection(
//             title: "Change Password",
//             child: Column(
//               children: [
//                 TextField(
//                   controller: controller.oldPassword,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: "Old Password *",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 TextField(
//                   controller: controller.newPassword,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: "New Password *",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 TextField(
//                   controller: controller.confirmPassword,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     labelText: "Confirm Password *",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Obx(
//                   () => SwitchListTile(
//                     contentPadding: EdgeInsets.zero,
//                     activeColor: appColor,
//                     title: const Text("Remove all sessions"),
//                     subtitle: const Text("Logout from all devices"),
//                     value: controller.removeAllSessions.value,
//                     // activeThumbColor: Colors.blue,
//                     trackColor: MaterialStateProperty.resolveWith<Color?>(
//                       (states) {
//                         if (states.contains(MaterialState.selected)) {
//                           return Colors.blue.withOpacity(0.5);
//                         }
//                         return Colors.grey.withOpacity(0.5);
//                       },
//                     ),
//                     onChanged: (val) {
//                       controller.toggleRemoveAllSessions(val);
//                     },
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: appColor,
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () {
//                       controller.callChangePasswordApi();
//                     },
//                     child: const Text("Save"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//
//           // Delete Account Section
//           _buildSection(
//             title: "Delete Account",
//             child: Column(
//               children: [
//                 TextField(
//                   controller: controller.emailTextController,
//                   decoration: InputDecoration(
//                     labelText: "Email Address *",
//                     border: OutlineInputBorder(),
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       foregroundColor: Colors.white,
//                     ),
//                     onPressed: () {
//                       print('Check Datatttatata---------');
//                       controller.callDeleteAccountApi();
//                       print('Check Datatttatata1111111111111---------');
//                     },
//                     child: const Text("Delete"),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Helper section box
//   Widget _buildSection({required String title, required Widget child}) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey.shade300),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 6,
//             spreadRadius: 2,
//             offset: const Offset(0, 3),
//           ),
//         ],
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               )),
//           const Divider(),
//           child,
//         ],
//       ),
//     );
//   }
// }
