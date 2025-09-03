import 'package:auto_route/annotations.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/cards_display/presentation/presentation.dart';

@RoutePage()
class CardsDisplayPage extends StatelessWidget {
  final String pageTitle;

  const CardsDisplayPage({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) => CardsDisplayWrapper(
        screenTitle: pageTitle,
      );
}
