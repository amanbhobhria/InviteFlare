import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/category/presentation/pages/category_page.dart';
import 'package:invite_flare/features/home/presentation/pages/home_page.dart';
import 'package:invite_flare/features/main/presentation/blocs/main_bloc/main_bloc.dart';
import 'package:invite_flare/features/main/presentation/presentation.dart';
import 'package:invite_flare/features/profile/presentation/pages/settings_page.dart';
import 'package:invite_flare/features/search/presentation/pages/search_page.dart';
import 'package:invite_flare/module/home_2/views/search_screen.dart';

class MainWrapper extends StatelessWidget {
  const MainWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<MainBloc>(),
        child: const _MainWrapper(),
      );
}


class _MainWrapper extends BaseStatelessWidget {
  const _MainWrapper();

  @override
  Widget buildWidget(BuildContext context) =>
      BlocSelector<MainBloc, MainState, int>(
        selector: (state) => state is MainUpdateState ? state.pageNo : 0,
        builder: (ctx, pageNo) => MainView(
          pageNo,
          (newPageNo) => context.read<MainBloc>().add(
                MainUpdatePageEvent(
                  pageNo: newPageNo,
                ),
              ),
          _getPage(
            pageNo: pageNo,
          ),
        ),
      );


  Widget _getPage({
    required int pageNo,
  }) =>
      switch (pageNo) {
        0 => const HomePage(),
        // 1 => const SearchPage(),
        1 => SearchCategoryScreen(),
        2 => const CategoryPage(),
        3 => const SettingsPage(fromBottomNav: true),
        _ => const HomePage()
      };
}
