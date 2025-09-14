import 'package:flutter/material.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:invite_flare/features/home/presentation/presentation.dart';
import 'package:invite_flare/shared/presentation/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/drawer/drawer_cubit.dart';
import '../widgets/side_nav.dart';
// import your custom appbar and other wrappers

class HomeWrapper extends StatelessWidget {
  HomeWrapper({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }
  @override
  Widget build(BuildContext context) => BlocListener<DrawerCubit, DrawerCommand>(
      listenWhen: (prev, curr) => curr is DrawerOpenRequested,
      listener: (context, state) {
        if (state is DrawerOpenRequested) {
          _openDrawer();
          context.read<DrawerCubit>().reset();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBarView.home(
          notificationCount: 4,
          appBarEnum: AppBarEnum.home,
          onNotificationPressed: () {},
          onProfilePressed: () {
            // instead of print, trigger drawer open
            context.read<DrawerCubit>().requestOpen();
          },
        ),

        drawer: const SideNav(),

        body: SingleChildScrollView(
          child: Column(
            children: [
              const CategoryWrapper(),
              const PromoBannerWrapper(),
              const IFSpace(),
              Divider(thickness: 8, color: Colors.grey.shade100),
              const ExpandableCardWrapper(),
              Divider(thickness: 8, color: Colors.grey.shade100),
              const ExpandableCardWrapper(),
              Divider(thickness: 8, color: Colors.grey.shade100),
              const ExplainerSectionWrapper(),
              Divider(thickness: 8, color: Colors.grey.shade100),
              const SloganWrapper(),
              const IFSpace(space: IFSpaces.xxxxxxL),
              const IFSpace(space: IFSpaces.xxxxL),
            ],
          ),
        ),
      ),
    );
}








// class HomeWrapper extends StatelessWidget {
//   const HomeWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBarView.home(
//         notificationCount: 4,
//         appBarEnum: AppBarEnum.home,
//         onNotificationPressed: () {},
//         onProfilePressed: () {
//
//           print("profile button pressed");
//
//
//         },
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const CategoryWrapper(),
//             const PromoBannerWrapper(),
//             const IFSpace(),
//             Divider(
//               thickness: 8,
//               color: Colors.grey.shade100,
//             ),
//             const ExpandableCardWrapper(),
//             Divider(
//               thickness: 8,
//               color: Colors.grey.shade100,
//             ),
//             const ExpandableCardWrapper(),
//             Divider(
//               thickness: 8,
//               color: Colors.grey.shade100,
//             ),
//             const ExplainerSectionWrapper(),
//             Divider(
//               thickness: 8,
//               color: Colors.grey.shade100,
//             ),
//             const SloganWrapper(),
//             const IFSpace(
//               space: IFSpaces.xxxxxxL,
//             ),
//             const IFSpace(
//               space: IFSpaces.xxxxL,
//             ),
//           ],
//         ),
//       ));
// }
