import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/card_details/card_details.dart';
import 'package:invite_flare/features/cards_display/presentation/presentation.dart';
import 'package:invite_flare/features/event_details/event_details.dart';
import 'package:invite_flare/features/global_search/global_search.dart';
import 'package:invite_flare/shared/domain/entities/invitation_card_entity.dart';

part 'app_router.gr.dart';

@injectable
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
            path: '/${GlobalSearchRoute.name}', page: GlobalSearchRoute.page),
        AutoRoute(
            path: '/${CardsDisplayRoute.name}', page: CardsDisplayRoute.page),
        AutoRoute(
            path: '/${CardDetailsRoute.name}', page: CardDetailsRoute.page),
        AutoRoute(
            path: '/${EventDetailsRoute.name}', page: EventDetailsRoute.page),
      ];
}
