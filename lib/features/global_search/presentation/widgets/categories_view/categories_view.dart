import 'package:invite_flare/core/core.dart';
import 'package:invite_flare/shared/shared.dart';

class CategoriesView extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) => MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

            return CategoryTile(
              name: category.title ?? '',
              icon: category.slug ?? '',
              cardColor: Utilities.colorFromHex(category.bgColor!),
              onTap: () {},
            );
          },
        ),
      );
}
