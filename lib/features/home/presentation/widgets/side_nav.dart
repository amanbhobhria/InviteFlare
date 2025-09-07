import 'package:flutter/material.dart';
import 'package:invite_flare/features/invitations/presentation/pages/invitations_page.dart';
import 'package:invite_flare/features/profile/presentation/pages/profile_page.dart';
import 'package:invite_flare/features/profile/presentation/pages/settings_page.dart';
import 'package:invite_flare/features/profile/presentation/pages/transactions_page.dart';

class SideNav extends StatelessWidget {
  const SideNav({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ProfilePage(),
                  ),
                );
              },
            ),


            ListTile(
              leading: const Icon(Icons.mail),
              title: const Text('Invitations'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InvitationsPage()),
                );
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




            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context); // close drawer first
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SettingsPage(),
                  ),
                );
              },
            ),

            const ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
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

