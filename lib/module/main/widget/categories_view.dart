import 'package:flutter/material.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';
import 'package:invite_flare/shared/shared.dart';
import 'package:invite_flare/core/core.dart';

class CategoriesView extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoriesView({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,           // 3 columns
          crossAxisSpacing: 8,         // Horizontal space between tiles
          mainAxisSpacing: 8,          // Vertical space between tiles
        ),
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(), // Smooth scrolling
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];

          return CategoryTile(
            name: category.title ?? '',
            icon: category.slug ?? '',
            cardColor: Utilities.colorFromHex(category.bgColor ?? '#FFFFFF'),
            onTap: () {
              // TODO: Handle tap action
            },
          );
        },
      ),
    );
  }
}
