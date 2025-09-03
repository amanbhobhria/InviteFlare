import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/core/utilities/utilities.dart';
import 'package:invite_flare/features/home/presentation/presentation.dart';
import 'package:invite_flare/shared/shared.dart';

class CategoryWrapper extends BaseStatelessWidget {
  const CategoryWrapper({super.key});

  @override
  Widget buildWidget(BuildContext context) => BlocProvider(
        create: (context) => getIt<CategoryBloc>()..add(FetchCategoryEvent()),
        child: const _CategoryWrapper(),
      );
}

class _CategoryWrapper extends StatelessWidget {
  const _CategoryWrapper();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) => switch (state) {
                CategoryInitial() || CategoryLoadingState() => const Center(
                    child: CircularProgressIndicator(),
                  ),
                CategorySuccessState() => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 24,
                      ),
                      child: Row(
                        children: List.generate(
                          state.categories.length,
                          (index) => CategoryTile(
                            name: state.categories[index].title ?? '',
                            icon: state.categories[index].title ?? '',
                            cardColor: Utilities.colorFromHex((state
                                        .categories[index].bgColor
                                        .toString()
                                        .isEmpty
                                    ? '#fbf6ee'
                                    : state.categories[index].bgColor) ??
                                '#fbf6ee'),
                            onTap: () {
                              context.router.push(CardsDisplayRoute(
                                  pageTitle:
                                      state.categories[index].slug ?? ''));
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                CategoryErrorState() => const SizedBox.shrink(),
              });
}
