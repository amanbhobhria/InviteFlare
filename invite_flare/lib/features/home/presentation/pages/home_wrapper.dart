import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/features/home/presentation/presentation.dart';
import 'package:invite_flare/shared/presentation/presentation.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarView.home(
        notificationCount: 4,
        appBarEnum: AppBarEnum.home,
        onNotificationPressed: () {},
        onProfilePressed: () {},
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CategoryWrapper(),
            const PromoBannerWrapper(),
            const IFSpace(),
            Divider(
              thickness: 8,
              color: Colors.grey.shade100,
            ),
            const ExpandableCardWrapper(),
            Divider(
              thickness: 8,
              color: Colors.grey.shade100,
            ),
            const ExpandableCardWrapper(),
            Divider(
              thickness: 8,
              color: Colors.grey.shade100,
            ),
            const ExplainerSectionWrapper(),
            Divider(
              thickness: 8,
              color: Colors.grey.shade100,
            ),
            const SloganWrapper(),
            const IFSpace(
              space: IFSpaces.xxxxxxL,
            ),
            const IFSpace(
              space: IFSpaces.xxxxL,
            ),
          ],
        ),
      ));
}
