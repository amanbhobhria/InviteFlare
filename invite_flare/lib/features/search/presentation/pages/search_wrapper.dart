import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/search/search.dart';
import 'package:invite_flare/shared/presentation/presentation.dart';

class SearchWrapper extends StatelessWidget {
  const SearchWrapper({super.key});

  @override
  Widget build(BuildContext context) => const _SearchWrapper();
}

class _SearchWrapper extends StatelessWidget {
  const _SearchWrapper();

  @override
  Widget build(BuildContext context) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              stretch: true,
              centerTitle: true,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              title: IFHeading(
                text: SearchConstants.searchTxt,
                headingSize: IFHeadingSize.xxxxL,
                textWeight: IFTextWeight.regular,
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(56),
                child: Container(
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: const SearchFieldWrapper()),
              ),
            ),
            const SliverToBoxAdapter(
              child: RecentSearchWrapper(),
            ),
          ],
        ),
      );
}
