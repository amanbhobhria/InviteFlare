import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';
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
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IFText(
              text: heading,
              textSize: IFTextSize.xxS,
              textColor: IFTextColors.BODY,
            ),
            const IFSpace(
              space: IFSpaces.xxS,
            ),
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
