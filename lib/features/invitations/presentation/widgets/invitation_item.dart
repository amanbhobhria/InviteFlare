import 'package:flutter/material.dart';
import 'package:invite_flare/features/invitations/domain/invitation.dart';


class InvitationItem extends StatelessWidget {
  final Invitation invitation;

  const InvitationItem({super.key, required this.invitation});

  @override
  Widget build(BuildContext context) => Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        title: Text(invitation.eventName,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Host: ${invitation.hostName}"),
            Text("Status: ${invitation.status}"),
            Text("Date: ${invitation.eventDate.toLocal().toString().split(' ')[0]}"),
          ],
        ),
        trailing: Text(invitation.invitationId,
            style: const TextStyle(color: Colors.grey)),
      ),
    );
}
