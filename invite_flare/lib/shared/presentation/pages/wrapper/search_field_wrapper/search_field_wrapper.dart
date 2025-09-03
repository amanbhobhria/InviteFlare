import 'package:flutter_svg/flutter_svg.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/extensions/extensions.dart';
import 'package:invite_flare/app/navigation/app_router.dart';
import 'package:invite_flare/core/base/base.dart';
import 'package:invite_flare/features/search/presentation/search_constants.dart';

class SearchFieldWrapper extends StatelessWidget {
  const SearchFieldWrapper({super.key});

  @override
  Widget build(BuildContext context) => const _SearchFieldWrapper();
}

class _SearchFieldWrapper extends StatelessWidget {
  const _SearchFieldWrapper();

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.router.push(
          const GlobalSearchRoute(),
        ),
        child: IFSearchField(
          hint: SearchConstants.searchHintTxt,
          isEnabled: false,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SvgPicture.asset(
              IFIcons.search,
              width: 24,
              height: 24,
            ),
          ),
        ),
      );
}
