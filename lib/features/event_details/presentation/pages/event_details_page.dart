import 'package:auto_route/auto_route.dart';
import 'package:invite_flare/core/core.dart';
import 'package:invite_flare/features/event_details/presentation/pages/pages.dart';

@RoutePage()
class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) => const EventDetailsWrapper();
}
