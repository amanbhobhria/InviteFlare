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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 45.0, vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            height: 70,
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
                unselectedIconTheme: const IconThemeData(color: Colors.white54),
                unselectedLabelStyle: IFTextStyles.style.textStyle(
                  textSize: IFTextSize.xS,
                  textWeight: IFTextWeight.regular,
                  textStyle: IFTextColors.OPACITY_WHITE,
                ),
                selectedIconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                useLegacyColorScheme: false,
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
    );
  }
}
