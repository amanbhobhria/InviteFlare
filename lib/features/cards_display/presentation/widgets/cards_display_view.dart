import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/cards_display/domain/domain.dart';
import 'package:invite_flare/features/cards_display/presentation/presentation.dart';

class CardsDisplayView extends StatelessWidget {
  final List<FilterEntity> filters;
  final List<SubCategoryEntity> subcategories;
  final Function() onTapFilter;
  final String categoryName;

  const CardsDisplayView({
    super.key,
    required this.filters,
    required this.subcategories,
    required this.onTapFilter,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const IFSpace(
              space: IFSpaces.xS,
            ),
            Expanded(
              child: InvitationCardsWrapper(
                  selectedFilters: filters,
                  subcategories: subcategories,
                  categoryName: categoryName),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: onTapFilter,
          elevation: 1,
          disabledElevation: 1,
          label: const IFText(text: 'Filter'),
          icon: const Icon(Icons.filter_list),
        ),
      );
}
