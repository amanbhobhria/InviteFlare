import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/category/presentation/presentation.dart';
import 'package:invite_flare/features/global_search/presentation/widgets/widgets.dart';
import 'package:invite_flare/shared/shared.dart';

class CategoriesWrapper extends StatelessWidget {
  const CategoriesWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<CategoriesBloc>()
          ..add(
            const OnGetCategoriesEvent(categoryName: 'LOL'),
          ),
        child: const _CategoriesWrapper(),
      );
}

class _CategoriesWrapper extends StatelessWidget {
  const _CategoriesWrapper();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) => switch (state) {
                CategoriesInitial() ||
                CategoriesLoading() =>
                  const LoadingView(),
                CategoriesSuccess() => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CategoriesView(
                      categories: state.categories,
                    ),
                  ),
              });
}
