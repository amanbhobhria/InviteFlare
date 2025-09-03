import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/cards_display/domain/domain.dart';
import 'package:invite_flare/features/cards_display/presentation/presentation.dart';
import 'package:invite_flare/shared/presentation/widgets/invitation_card_view/invitation_card_item.dart';

class InvitationCardsWrapper extends StatelessWidget {
  final List<FilterEntity> selectedFilters;
  final List<SubCategoryEntity> subcategories;
  final String categoryName;

  const InvitationCardsWrapper({
    super.key,
    required this.selectedFilters,
    required this.subcategories,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<InvitationCardsBloc>()
          ..add(
            OnInvitationCardsLoadEvent(
                subcategories: subcategories, categoryName: categoryName),
          ),
        child: const _InvitationCardsWrapper(),
      );
}

class _InvitationCardsWrapper extends StatelessWidget {
  const _InvitationCardsWrapper();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<InvitationCardsBloc, InvitationCardsState>(
        builder: (context, state) => switch (state) {
          InvitationCardsInitial() || InvitationCardsLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          InvitationCardsSuccess() => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SubcategoriesView(
                  subcategories: state.subcategories,
                  onTapSubcategory: (selectedItem) {
                    //todo: implement subcategory filter
                  },
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.7,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: state.invitationCards.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final card = state.invitationCards[index];
                        //List<Color> colors = card['colors'] as List<Color>;
                        return InvitationCardItem(
                          imageURL: card.thumb!,
                          cardTitle: card.title ?? '',
                          //colorOptions: card['colors'],
                          onTapInvitationCard: () {
                            context.router.push(
                              CardDetailsRoute(
                                card: card,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          InvitationCardsFailure() => Center(child: IFText(text: state.error))
        },
      );
}
