// ignore_for_file: prefer_expression_function_bodies

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invite_flare/module/profile/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  final controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Profile"),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  // Profile Image
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.profileImage != null
                              ? FileImage(controller.profileImage!)
                              : const AssetImage(
                                      "assets/images/png/profile.png")
                                  as ImageProvider,
                        ),
                        // Positioned(
                        //   bottom: 0,
                        //   right: 0,
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       showModalBottomSheet(
                        //         context: context,
                        //         builder: (_) => _buildImagePickerSheet(),
                        //       );
                        //     },
                        //     child: const CircleAvatar(
                        //       radius: 18,
                        //       backgroundColor: Colors.blue,
                        //       child: Icon(Icons.camera_alt,
                        //           color: Colors.white, size: 18),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Name
                  TextFormField(
                    controller: controller.nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Name is required"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Email
                  TextFormField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      labelText: "Email Address",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) => value == null || value.isEmpty
                        ? "Email is required"
                        : null,
                  ),
                  const SizedBox(height: 16),

                  // Phone
                  TextFormField(
                    controller: controller.phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Two Factor Authentication toggle
                  SwitchListTile(
                    title: const Text("Two-Factor Authentication"),
                    subtitle: Text(
                      controller.isTwoFactorEnabled
                          ? "Enabled (Verified)"
                          : "Disabled",
                    ),
                    activeColor: Colors.blue,
                    inactiveThumbColor: Colors.grey,
                    trackColor: MaterialStateProperty.resolveWith<Color?>(
                      (states) {
                        if (states.contains(MaterialState.selected)) {
                          return Colors.blue.withOpacity(0.5);
                        }
                        return Colors.grey.withOpacity(0.5);
                      },
                    ),
                    value: controller.isTwoFactorEnabled,
                    onChanged: controller.toggleTwoFactor,
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      controller.callUpdateProfileApi();
                    },
                    child: const Text("Save Profile"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePickerSheet() => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(Get.context!);
                controller.pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(Get.context!);
                controller.pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      );
}
