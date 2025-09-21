import 'package:flutter/material.dart';

class ExpandableCardView extends StatelessWidget {
  final String heading;
  final String description;
  final List<dynamic> invitationCards;

  const ExpandableCardView({
    super.key,
    required this.heading,
    required this.description,
    required this.invitationCards,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              itemCount: invitationCards.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final card = invitationCards[index];
                return Card(
                  child: ListTile(
                    title: Text(card['name']),
                    subtitle: Text(card['name']),
                  ),
                );
              },
            ),
          ],
        ),
      );
}
