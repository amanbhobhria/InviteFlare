import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/global_search/global_search.dart';
import 'package:invite_flare/features/global_search/presentation/blocs/global_search_bloc/global_search_bloc.dart';
import 'package:invite_flare/shared/presentation/widgets/invitation_card_view/invitation_card_item.dart';

class GlobalSearchWrapper extends StatelessWidget {
  const GlobalSearchWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<GlobalSearchBloc>()
          ..add(
            OnGlobalSearchInitEvent(),
          ),
        child: const _GlobalSearchWrapper(),
      );
}

class _GlobalSearchWrapper extends StatelessWidget {
  const _GlobalSearchWrapper();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GlobalSearchFieldWrapper(
            onSearch: (value) => Future.delayed(
                const Duration(milliseconds: 500),
                () => context.read<GlobalSearchBloc>().add(
                      OnGlobalSearchCardsEvent(
                        searchText: value.trim(),
                      ),
                    )),
          ),
        ),
        body: BlocBuilder<GlobalSearchBloc, GlobalSearchState>(
          builder: (context, state) => switch (state) {
            GlobalSearchInitial() || GlobalSearchLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            GlobalSearchSuccess() => state.invitationCards.isNotEmpty
                ? Padding(
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
                      itemBuilder: (context, index) {
                        final card = state.invitationCards[index];
                        //List<Color> colors = card['colors'] as List<Color>;
                        return InvitationCardItem(
                          imageURL: card.thumb!,
                          cardTitle: card.title ?? '',
                          //colorOptions: card['colors'],
                        );
                      },
                    ),
                  )
                : const Center(
                    child: IFText(
                      text: 'Invitation Card not found',
                    ),
                  ),
            GlobalSearchError() => Center(
                child: IFText(
                  text: state.error,
                ),
              ),
          },
        ),
      );
}
