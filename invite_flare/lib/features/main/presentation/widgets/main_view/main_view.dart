import 'package:flutter_svg/flutter_svg.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/app.dart';
import 'package:invite_flare/core/base/base.dart';

class MainView extends BaseStatelessWidget {
  final int pageNo;
  final Function(int) onPageChanged;
  final Widget? pageView;

  const MainView(
    this.pageNo,
    this.onPageChanged,
    this.pageView, {
    super.key,
  });

  @override
  Widget buildWidget(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            PageView.builder(
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) => pageView,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: IFBottomNavigation(
                onTap: onPageChanged,
                currentIndex: pageNo,
                navItems: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.homeNavIcon,
                      semanticsLabel: 'Dart Logo',
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        pageNo == 0 ? Colors.white : Colors.white54,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: homeNavTxt,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.searchNavIcon,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        pageNo == 1 ? Colors.white : Colors.white54,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: searchNavTxt,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.categoryNavIcon,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        pageNo == 2 ? Colors.white : Colors.white54,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: categoryNavTxt,
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      AppAssets.settingNavIcon,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        pageNo == 3 ? Colors.white : Colors.white54,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: settingNavTxt,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
