import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/cards_display/domain/domain.dart';

class SubcategoriesView extends StatelessWidget {
  final List<SubCategoryEntity> subcategories;
  final Function(SubCategoryEntity) onTapSubcategory;

  const SubcategoriesView({
    super.key,
    required this.subcategories,
    required this.onTapSubcategory,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              subcategories.length,
              (index) => IFCard(
                borderRadius: BorderRadius.circular(8),
                onTap: () => onTapSubcategory(subcategories[index]),
                surfaceColor: IFColors.BRAND_LIGHT,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 8.0),
                  child: IFText(
                    text: subcategories[index].title ?? '',
                    textSize: IFTextSize.S,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
