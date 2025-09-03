import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/features/search/presentation/presentation.dart';

class RecentSearchWrapper extends StatelessWidget {
  const RecentSearchWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<RecentSearchBloc>()
          ..add(
            GetRecentSearchEvent(),
          ),
        child: const _RecentSearchWrapper(),
      );
}

class _RecentSearchWrapper extends StatelessWidget {
  const _RecentSearchWrapper();

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<RecentSearchBloc, RecentSearchState>(
        builder: (context, state) => switch (state) {
          RecentSearchInitial() || RecentSearchLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          RecentSearchSuccess() => RecentSearchView(
              heading: 'Recent search',
              onTapDelete: (data) {
                print(data);
              },
              recentSearches: const [
                'Birthday',
                'christ',
                'wedd',
                'Christmas',
              ],
            ),
          RecentSearchError() => const SizedBox.shrink(),
        },
      );
}
