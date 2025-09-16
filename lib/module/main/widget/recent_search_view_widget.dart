import 'package:flutter/material.dart';
import 'package:invite_flare/features/search/presentation/widgets/recent_search_view/recent_search_item.dart';

class RecentSearchView extends StatelessWidget {
  final List<String> recentSearches;
  final String heading;
  final Function(String) onTapDelete;

  const RecentSearchView({
    super.key,
    required this.recentSearches,
    required this.onTapDelete,
    required this.heading,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(heading,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                recentSearches.length,
                (index) => RecentSearchItem(
                  text: recentSearches[index],
                  onTapDelete: () => onTapDelete(recentSearches[index]),
                ),
              ),
            ),
          ],
        ),
      );
}
