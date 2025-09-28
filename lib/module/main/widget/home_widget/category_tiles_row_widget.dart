import 'package:flutter/material.dart';
import 'package:invite_flare/shared/domain/entities/category_entity.dart';
import 'package:invite_flare/shared/shared.dart';
import 'package:invite_flare/core/utilities/utilities.dart';

class CategoryTilesRow extends StatelessWidget {
  final List<CategoryEntity> categories;

  const CategoryTilesRow({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Row(
          children: List.generate(
            categories.length,
            (index) {
              final category = categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CategoryTile(
                  name: category.title ?? '',
                  icon: category.slug ?? '',
                  cardColor: Utilities.colorFromHex(category.bgColor ?? '#fbf6ee'),
                  onTap: () {
                    // Navigate to details if needed
                  },
                ),
              );
            },
          ),
        ),
      );


}
