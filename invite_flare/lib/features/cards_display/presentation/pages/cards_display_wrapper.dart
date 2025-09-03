import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/core.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/cards_display/domain/domain.dart';
import 'package:invite_flare/features/cards_display/presentation/presentation.dart';
import 'package:invite_flare/shared/shared.dart';

class CardsDisplayWrapper extends StatelessWidget {
  final String screenTitle;

  const CardsDisplayWrapper({super.key, required this.screenTitle});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<CardsDisplayBloc>()
          ..add(OnCardsDisplayEvent(categoryName: screenTitle)),
        child: _CardsDisplayWrapper(screenTitle: screenTitle),
      );
}

class _CardsDisplayWrapper extends StatelessWidget {
  final String screenTitle;

  const _CardsDisplayWrapper({required this.screenTitle});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarView.other(
          pageTitle: screenTitle,
          actions: [
            IconButton(
              onPressed: () => context.router.push(
                const GlobalSearchRoute(),
              ),
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: BlocBuilder<CardsDisplayBloc, CardsDisplayState>(
          builder: (context, state) => switch (state) {
            CardsDisplayInitial() || CardsDisplayLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            CardsDisplayLoaded() => CardsDisplayView(
                filters: state.subcategoriesAndFilterEntity.filters ?? [],
                subcategories:
                    state.subcategoriesAndFilterEntity.subcategory ?? [],
                onTapFilter: () => _showFilterBottomSheet(
                    context, state.subcategoriesAndFilterEntity.filters ?? []),
                categoryName: screenTitle),
            CardsDisplayFailure() => Center(child: IFText(text: state.error))
          },
        ),
      );
}

void _showFilterBottomSheet(BuildContext context, List<FilterEntity> filters) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => FilterBottomSheet(filters: filters),
  ).then((value) {
    if (value != null) {
      final filteredValue = value as List<FilterEntity>;
      final appliedFilters = filteredValue
          .map((filter) => {
                'filterName': filter.name,
                'selectedValue': filter.selectedValue?.toJson(),
              })
          .toList();

      print('Applied Filterss: $appliedFilters');

      //TODO: Implement filter api call event
    }
  });
}
