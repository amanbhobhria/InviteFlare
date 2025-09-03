import 'package:auto_route/auto_route.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/global_search/presentation/presentation.dart';

@RoutePage()
class GlobalSearchPage extends StatelessWidget {
  const GlobalSearchPage({super.key});

  @override
  Widget build(BuildContext context) => const GlobalSearchWrapper();
}
