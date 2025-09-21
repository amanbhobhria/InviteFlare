import 'package:flutter/material.dart';
import 'package:invite_flare/core/services/token_service.dart';
import 'package:invite_flare/core_2/data/remote_service/network/dio_client.dart';
import 'package:invite_flare/core_2/data/remote_service/network/network_exceptions.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/features/profile/presentation/pages/transactions_page.dart';
import 'package:invite_flare/module/authentication/views/login_screen.dart';
import 'package:invite_flare/module/profile/views/invitation_list_screen.dart';

class SideNav extends StatelessWidget {
  final scaffoldKey;
  const SideNav({super.key,this.scaffoldKey});

  @override
  Widget build(BuildContext context) => Drawer(
    key:scaffoldKey ,
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.zero,
                child: UserInfoSection(),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context); // close drawer first

                  Get.toNamed(AppRoutes.profileScreen);
                },
              ),
              ListTile(
                leading: const Icon(Icons.mail),
                title: const Text('Invitations'),
                onTap: () {
                  Navigator.pop(context);
                  Get.to(() => InvitationsListScreen());
                },
              ),
              ListTile(
                leading: const Icon(Icons.account_balance_wallet),
                title: const Text('Transactions'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TransactionsPage(),
                    ),
                  );
                },
              ),

              // ListTile(
              //   leading: const Icon(Icons.settings),
              //   title: const Text('Settings'),
              //   onTap: () {
              //     Navigator.pop(context); // close drawer first
              //     try {
              //       Get.toNamed(AppRoutes.settingScreen);
              //     } catch (e) {
              //       debugPrint("Error navigating to settings: $e");
              //     }
              //   },
              // ),

              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Log Out'),
                onTap: () async {
                  try {
                    DioClient dioClient =
                        DioClient(Dio()); // ✅ No need to pass baseUrl

                    await dioClient
                        .post('api/v1/accounts/logout', skipAuth: false)
                        .then((value) async {
                      if (value != null) {
                        await TokenService().deleteAccessToken();
                        Navigator.pushAndRemoveUntil(
                          Get.context!,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      }
                    }).onError(
                      (error, stackTrace) {
                        NetworkExceptions.getDioException(error);
                        toast(NetworkExceptions.messageData);
                      },
                    );
                  } catch (e) {
                    debugPrint("Error: $e");
                  }
                },
              ),
            ],
          ),
        ),
      );
}

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({super.key});

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Profile picture

            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/png/profile.png'),
              // add a sample profile.png in assets
            ),

            SizedBox(width: 16),
            // Name + Email
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "John Doe",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "john.doe@email.com",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
