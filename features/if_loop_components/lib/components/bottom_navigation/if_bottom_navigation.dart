part of '../../if_loop_components.dart';

class IFBottomNavigation extends StatelessWidget {
  final List<BottomNavigationBarItem> navItems;
  final Function(int)? onTap;
  final int currentIndex;

  const IFBottomNavigation({
    super.key,
    required this.navItems,
    this.currentIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return SafeArea(
      top: false, // only care about bottom
      child: Padding(
        // reduce bottom padding to avoid overflow + add safe area dynamically
        padding: EdgeInsets.only(
          left: 45.0,
          right: 45.0,
          bottom: bottomPadding > 0 ? bottomPadding / 2 : 8, // adaptive
          top: 8,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              // height slightly reduced so total with padding fits in screen
              height: 65,
              decoration: BoxDecoration(
                color: const Color(0xff0D2B1B).withOpacity(0.70),
                border: Border.all(color: Colors.white24, width: 1),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: BottomNavigationBar(
                  fixedColor: Colors.white,
                  currentIndex: currentIndex,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  showUnselectedLabels: false,
                  onTap: onTap,
                  unselectedIconTheme:
                  const IconThemeData(color: Colors.white54),
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  useLegacyColorScheme: false,
                  unselectedLabelStyle: IFTextStyles.style.textStyle(
                    textSize: IFTextSize.xS,
                    textWeight: IFTextWeight.regular,
                    textStyle: IFTextColors.OPACITY_WHITE,
                  ),
                  selectedLabelStyle: IFTextStyles.style.textStyle(
                    textSize: IFTextSize.xS,
                    textWeight: IFTextWeight.regular,
                    textStyle: IFTextColors.WHITE,
                  ),
                  items: navItems,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

