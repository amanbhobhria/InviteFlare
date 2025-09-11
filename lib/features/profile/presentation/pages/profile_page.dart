import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/profile/presentation/blocs/events/profile_events.dart';
import 'package:invite_flare/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:invite_flare/features/profile/presentation/blocs/state/profile_state.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (ctx) => getIt<ProfileBloc>()..add(LoadProfile()),
      child: const _ProfileView(),
    );
}

class _ProfileView extends StatefulWidget {
  const _ProfileView();

  @override
  State<_ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<_ProfileView> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isTwoFactorEnabled = false;

  @override
  Widget build(BuildContext context) => BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Profile updated successfully")),
          );
        }
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error!)),
          );
        }
      },
      builder: (context, state) {
        if (state.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        _nameController.text = state.name ?? '';
        _emailController.text = state.email ?? '';
        _phoneController.text = state.phone ?? '';
        _isTwoFactorEnabled = state.twoFactor;

        return Scaffold(
          appBar: AppBar(title: const Text("Profile")),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Profile Image
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage != null
                        ? FileImage(_profileImage!)
                        : (state.profileImage != null
                        ? NetworkImage(state.profileImage!)
                        : const AssetImage('assets/images/png/profile.png'))
                    as ImageProvider,
                  ),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (v) =>
                    v == null || v.isEmpty ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(labelText: "Phone"),
                  ),
                  const SizedBox(height: 16),

                  SwitchListTile(
                    title: const Text('Two-Factor Authentication'),
                    value: _isTwoFactorEnabled,
                    onChanged: (val) {
                      setState(() => _isTwoFactorEnabled = val);
                    },
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<ProfileBloc>().add(SaveProfile(
                          name: _nameController.text,
                          email: _emailController.text,
                          phone: _phoneController.text,
                          twoFactor: _isTwoFactorEnabled,
                          profileImage: state.profileImage,
                        ));
                      }
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




//
// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }
//
//
// class _ProfilePageState extends State<ProfilePage> {
//   final _formKey = GlobalKey<FormState>();
//
//   File? _profileImage;
//   final _nameController = TextEditingController(text: "John Doe");
//   final _emailController = TextEditingController(text: "john.doe@email.com");
//   final _phoneController = TextEditingController();
//
//   bool _isTwoFactorEnabled = false;
//
//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       setState(() {
//         _profileImage = File(pickedFile.path);
//       });
//     }
//   }
//
//
//   void _toggleTwoFactor(bool value) {
//     if (value && _phoneController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Enter phone number to enable Two-Factor Authentication"),
//         ),
//       );
//       return;
//     }
//     setState(() {
//       _isTwoFactorEnabled = value;
//     });
//   }
//
//
//
//   void _saveProfile() {
//     if (_formKey.currentState!.validate()) {
//       // Later: Call your Bloc event or repository to save
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Profile saved successfully")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile"),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Profile Image
//               Center(
//                 child: Stack(
//                   children: [
//                     CircleAvatar(
//                       radius: 50,
//                       backgroundImage: _profileImage != null
//                           ? FileImage(_profileImage!)
//                           : const AssetImage("assets/images/png/profile.png") as ImageProvider,
//                     ),
//
//                     Positioned(
//                       bottom: 0,
//                       right: 0,
//                       child: GestureDetector(
//                         onTap: () {
//                           showModalBottomSheet(
//                             context: context,
//                             builder: (_) => _buildImagePickerSheet(),
//                           );
//                         },
//                         child: const CircleAvatar(
//                           radius: 18,
//                           backgroundColor: Colors.blue,
//                           child: Icon(Icons.camera_alt, color: Colors.white, size: 18),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               const SizedBox(height: 20),
//
//               // Name
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: "Name",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) =>
//                 value == null || value.isEmpty ? "Name is required" : null,
//               ),
//               const SizedBox(height: 16),
//
//               // Email
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: "Email Address",
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) =>
//                 value == null || value.isEmpty ? "Email is required" : null,
//               ),
//               const SizedBox(height: 16),
//
//               // Phone
//               TextFormField(
//                 controller: _phoneController,
//                 keyboardType: TextInputType.phone,
//                 decoration: const InputDecoration(
//                   labelText: "Phone Number",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 16),
//
//               // Two Factor Authentication toggle
//               SwitchListTile(
//                 title: const Text("Two-Factor Authentication"),
//                 subtitle: Text(
//                   _isTwoFactorEnabled
//                       ? "Enabled (Verified)"
//                       : "Disabled",
//                 ),
//                 value: _isTwoFactorEnabled,
//                 onChanged: _toggleTwoFactor,
//               ),
//               const SizedBox(height: 30),
//
//               ElevatedButton(
//                 onPressed: _saveProfile,
//                 child: const Text("Save Profile"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//
//   Widget _buildImagePickerSheet() => SafeArea(
//       child: Wrap(
//         children: [
//           ListTile(
//             leading: const Icon(Icons.photo_library),
//             title: const Text("Gallery"),
//             onTap: () {
//               Navigator.pop(context);
//               _pickImage(ImageSource.gallery);
//             },
//           ),
//           ListTile(
//             leading: const Icon(Icons.camera_alt),
//             title: const Text("Camera"),
//             onTap: () {
//               Navigator.pop(context);
//               _pickImage(ImageSource.camera);
//             },
//           ),
//         ],
//       ),
//     );
// }
