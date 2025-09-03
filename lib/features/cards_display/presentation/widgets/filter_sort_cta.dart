import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/core.dart';

class FilterSortCta extends StatelessWidget {
  const FilterSortCta({super.key});

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IFButton(
            text: 'Filter',
            onPressed: () {
              _filterDialog(context);
            },
            icon: const Icon(Icons.filter_list),
            buttonStyle: IFButtonStyle.TEXT,
            buttonType: IFButtonType.SECONDARY,
            buttonSize: IFButtonSize.MIN,
          ),
          IFButton(
            text: 'Popular',
            onPressed: () {},
            icon: const Icon(Icons.sort),
            buttonStyle: IFButtonStyle.TEXT,
            buttonType: IFButtonType.SECONDARY,
            buttonSize: IFButtonSize.MIN,
          ),
        ],
      );

  void _filterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialogUtils(
        title: 'Filter',
        content: const IFText(
          text: 'Select your filter options',
          textSize: IFTextSize.S,
          textAlign: TextAlign.center,
        ),
        actions: [
          IFButton(
            text: 'Cancel',
            onPressed: () => Navigator.of(context).pop(),
            buttonStyle: IFButtonStyle.TEXT,
            buttonSize: IFButtonSize.MIN,
          ),
        ],
      ),
    );
  }
}
