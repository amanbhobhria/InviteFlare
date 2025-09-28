import 'package:flutter/material.dart';

class RecentSearchItem extends StatelessWidget {
  final String text;
  final VoidCallback onTapDelete;

  const RecentSearchItem({
    super.key,
    required this.text,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: const TextStyle(fontSize: 14)),
            const SizedBox(width: 6),
            InkWell(
              onTap: onTapDelete,
              child: const Icon(Icons.close, size: 16),
            ),
          ],
        ),
      );
}
