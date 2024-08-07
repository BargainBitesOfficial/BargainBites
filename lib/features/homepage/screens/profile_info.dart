import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bargainbites/features/startup/screens/user_type.dart';

import 'package:bargainbites/utils/constants/colors.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "";

  String userEmail = "";

  final String? email = FirebaseAuth.instance.currentUser!.email;

  @override
  void initState() {
    super.initState();
    fetchUserDetailsByEmail();
  }

  void fetchUserDetailsByEmail() async {
    if (email != null) {
      var userSnapshot = (await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: email)
          .get()).docs.first;

      // if (userSnapshot.docs.isNotEmpty) {
        setState(() {
          userName = userSnapshot['name'];
          userEmail = userSnapshot['email'];
          // userDetails = userSnapshot.docs.first.data();
        });
      // }
    }
  }

  // final String? email = user.email;

  void signUserOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const UserType()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              gradient: TColors.linerGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 48),
                // to compensate for the status bar height
                Text(
                  'Hello, $userName',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: const TextStyle(
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
                    // print('Account settings tapped');
                  },
                ),
                // _buildListItem(
                //   context,
                //   icon: Icons.notifications,
                //   title: 'Notifications',
                //   subtitle: 'Get all your updates here',
                //   onTap: () {
                //     // Handle Notifications tap
                //     print('Notifications tapped');
                //   },
                // ),
                // _buildListItem(
                //   context,
                //   icon: Icons.star,
                //   title: 'Rate our App',
                //   subtitle: 'Help us get 5 stars',
                //   onTap: () {
                //     // Handle Rate our App tap
                //     print('Rate our App tapped');
                //   },
                // ),
                _buildListItem(
                  context,
                  icon: Icons.logout,
                  title: 'Sign Out',
                  onTap: () {
                    signUserOut();
                    // print('Sign Out tapped');
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
      {required IconData icon,
      required String title,
      String? subtitle,
      required VoidCallback onTap}) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.black),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: subtitle != null ? Text(subtitle) : null,
          trailing: const Icon(Icons.chevron_right, color: Colors.black),
          onTap: onTap,
        ),
        Divider(),
      ],
    );
  }
}
