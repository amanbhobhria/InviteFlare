import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/app/extensions/extensions.dart';

enum AppBarEnum { home, other }

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? subtitle;
  final bool showBackButton;
  final int notificationCount;
  final List<Widget>? actions;
  final AppBarEnum appBarEnum;

  // Constructor for the AppBarWidget
  const AppBarView._({
    super.key,
    this.title,
    this.subtitle,
    this.notificationCount = 0,
    this.showBackButton = false,
    this.actions,
    this.appBarEnum = AppBarEnum.home,
  });

  /// Named constructor for the Home screen AppBar
  AppBarView.home({
    Key? key,
    required int notificationCount,
    required VoidCallback onNotificationPressed,
    required VoidCallback onProfilePressed,
    required AppBarEnum appBarEnum,
  }) : this._(
          key: key,
          title: null,
          // Home doesn't need a title
          showBackButton: false,
          notificationCount: notificationCount,
          appBarEnum: appBarEnum,
          actions: [
            if (appBarEnum == AppBarEnum.home)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      OutlinedButton(
                        onPressed: onNotificationPressed,
                        style: OutlinedButton.styleFrom(
                          shape: const CircleBorder(),
                          side: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),
                        child: const Icon(Icons.notifications,
                            color: Colors.grey, size: 24),
                      ),
                      if (notificationCount > 0)
                        Positioned(
                          right: 4,
                          top: 4,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.red,
                            child: IFText(
                              text: notificationCount.toString(),
                              textColor: IFTextColors.WHITE,
                              textSize: IFTextSize.xS,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const IFSpace(
                    space: IFSpaces.xxxS,
                    direction: IFSpaceDirection.HORIZONTAL,
                  ),
                  InkWell(
                    onTap: onProfilePressed,
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        'https://easy-peasy.ai/cdn-cgi/image/quality=70,format=auto,width=300/https://fdczvxmwwjwpwbeeqcth.supabase.co/storage/v1/object/public/images/50dab922-5d48-4c6b-8725-7fd0755d9334/3a3f2d35-8167-4708-9ef0-bdaa980989f9.png',
                      ),
                    ),
                  ),
                ],
              )
          ],
        );

  /// Named constructor for other screens
  const AppBarView.other({
    Key? key,
    required String pageTitle,
    String? pageSubTitle,
    List<Widget>? actions,
  }) : this._(
          key: key,
          subtitle: pageSubTitle,
          title: pageTitle,
          showBackButton: true,
          actions: actions,
        );

  @override
  Widget build(BuildContext context) => PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: showBackButton,
                  child: OutlinedButton(
                    onPressed: () => context.router.popForced(),
                    style: OutlinedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: Colors.grey.shade100,
                      side: BorderSide(
                        color: Colors.grey.shade100,
                        width: 0.5,
                      ),
                    ),
                    child: const Icon(Icons.arrow_back,
                        color: Colors.grey, size: 24),
                  ),
                ),
                Expanded(
                  child: showBackButton
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IFHeading(
                              text: title ?? '',
                              headingSize: IFHeadingSize.xL,
                            ),
                            if (subtitle != null)
                              IFText(
                                text: subtitle ?? '',
                                textSize: IFTextSize.xxS,
                                textColor: IFTextColors.DESCRIPTION,
                              ),
                          ],
                        )
                      : Image.asset(
                          'assets/images/png/AppLogo_Landscape.png',
                          fit: BoxFit.fitHeight,
                          alignment: Alignment.centerLeft,
                        ),
                ),
                if (actions != null) Row(children: actions!.toList()),
              ],
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
