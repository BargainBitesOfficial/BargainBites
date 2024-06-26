import 'package:flutter/material.dart';



class ProfilePage extends StatelessWidget {
  final String userName = 'Vinay Kumar';
  final String userEmail = 'vinaykumar@gmail.com';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 48), // to compensate for the status bar height
                Text(
                  'Hello, $userName',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildListItem(
                  context,
                  icon: Icons.person,
                  title: 'Account settings',
                  subtitle: 'Change personal information',
                  onTap: () {
                    // Handle Account settings tap
                    print('Account settings tapped');
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.notifications,
                  title: 'Notifications',
                  subtitle: 'Get all your updates here',
                  onTap: () {
                    // Handle Notifications tap
                    print('Notifications tapped');
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.star,
                  title: 'Rate our App',
                  subtitle: 'Help us get 5 stars',
                  onTap: () {
                    // Handle Rate our App tap
                    print('Rate our App tapped');
                  },
                ),
                _buildListItem(
                  context,
                  icon: Icons.logout,
                  title: 'Sign Out',
                  onTap: () {
                    // Handle Sign Out tap
                    print('Sign Out tapped');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(BuildContext context,
      {required IconData icon, required String title, String? subtitle, required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: Icon(Icons.chevron_right, color: Colors.black),
          onTap: onTap,
        ),
        Divider(),
      ],
    );
  }
}
