import 'package:flutter/material.dart';

class ExplainerSectionView extends StatelessWidget {
  final String heading;
  final List<dynamic> steps;

  const ExplainerSectionView({
    super.key,
    required this.heading,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Column(
              children: steps.map((step) {
                return ListTile(
                  leading: const Icon(Icons.check_circle_outline),
                  title: Text(step),
                );
              }).toList(),
            )
          ],
        ),
      );
}
