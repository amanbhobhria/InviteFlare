import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/cards_display/domain/domain.dart';

class FilterBottomSheet extends StatelessWidget {
  final List<FilterEntity> filters;

  const FilterBottomSheet({super.key, required this.filters});

  @override
  Widget build(BuildContext context) => StatefulBuilder(
        builder: (context, setState) => DraggableScrollableSheet(
          initialChildSize: 0.7,
          minChildSize: 0.5,
          expand: false,
          builder: (_, controller) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const IFSpace(
                  space: IFSpaces.xL,
                ),
                const IFHeading(
                  text: 'Filters',
                  headingSize: IFHeadingSize.xxxxxL,
                  textWeight: IFTextWeight.regular,
                ),
                const IFSpace(
                  space: IFSpaces.xS,
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: filters.length,
                    itemBuilder: (context, index) =>
                        _buildFilterSection(filters[index], setState),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IFButton(
                      text: 'Clear All',
                      onPressed: () {
                        setState(() {
                          for (final filter in filters) {
                            filter.selectedValue = null;
                          }
                        });
                      },
                      buttonSize: IFButtonSize.MIN,
                      buttonType: IFButtonType.SECONDARY,
                      buttonStyle: IFButtonStyle.TEXT,
                    ),
                    IFButton(
                      text: 'Apply',
                      buttonSize: IFButtonSize.MIN,
                      buttonType: IFButtonType.SECONDARY,
                      onPressed: () {
                        Navigator.pop(
                          context,
                          filters
                              .where((filter) => filter.selectedValue != null)
                              .toList(),
                        );
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );

  Widget _buildFilterSection(
    FilterEntity filterEntity,
    void Function(void Function()) setState,
  ) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IFText(
            text: filterEntity.name ?? '',
            textWeight: IFTextWeight.semiBold,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: filterEntity.values
                    ?.map((value) => _buildChip(filterEntity, value, setState))
                    .toList() ??
                [],
          ),
          const SizedBox(height: 16),
        ],
      );

  Widget _buildChip(FilterEntity filterEntity, Values value,
      void Function(void Function()) setState) {
    final isSelected = filterEntity.selectedValue?.value == value.value;

    return ChoiceChip(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? IFColors.TRANSPARENT : Colors.grey.shade400,
        ),
      ),
      selectedColor: IFColors.PERAGRAPH,
      checkmarkColor: IFColors.WHITE,
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.rgb != null)
            Container(
              width: 16,
              height: 16,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Color(int.parse('0xFF${value.rgb}')),
                shape: BoxShape.circle,
              ),
            ),
          IFText(
            text: value.name ?? '',
            textSize: IFTextSize.S,
            textWeight: IFTextWeight.semiBold,
            textAlign: TextAlign.center,
            textColor: isSelected ? IFTextColors.WHITE : IFTextColors.HEADING,
          ),
        ],
      ),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          filterEntity.selectedValue = selected ? value : null;
        });
      },
    );
  }
}
