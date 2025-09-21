import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invite_flare/features/invitations/presentation/widgets/invitation_item.dart';
import 'package:invite_flare/module/profile/controller/invitation_list_controller.dart';

class InvitationsListScreen extends StatelessWidget {
  InvitationsListScreen({super.key});

  final InvitationsController controller = Get.put(InvitationsController());

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Invitation",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("New Invitation tapped")),
                );
              },
              child: const Text(
                "New Invitation",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text(controller.errorMessage.value));
        }

        if (controller.invitations.isEmpty) {
          return const Center(child: Text("No invitations found"));
        }

        return ListView.builder(
          itemCount: controller.invitations.length,
          itemBuilder: (context, index) => InvitationItem(
            invitation: controller.invitations[index],
          ),
        );
      }),
    );
  }
}
