import 'package:auto_route/annotations.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/card_details/card_details.dart';
import 'package:invite_flare/shared/domain/entities/invitation_card_entity.dart';

@RoutePage()
class CardDetailsPage extends StatelessWidget {
  final Data card;

  const CardDetailsPage({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) => CardDetailsWrapper(card: card, );
}
