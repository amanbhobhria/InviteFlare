import 'package:auto_route/annotations.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/category/presentation/presentation.dart';

@RoutePage()
class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) => const _CategoryPageWrapper();
}

class _CategoryPageWrapper extends BaseStatelessWidget {
  const _CategoryPageWrapper();

  @override
  Widget buildWidget(BuildContext context) => const Scaffold(
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
                // text: categoryNavTxt,
                text: 'a,am',
                headingSize: IFHeadingSize.xxxxL,
                textWeight: IFTextWeight.regular,
              ),
            ),
            SliverToBoxAdapter(
              child: CategoriesWrapper(),
            )
          ],
        ),
      );
}
