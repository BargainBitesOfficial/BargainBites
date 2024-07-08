import 'package:bargainbites/features/homepage/screens/navbar.dart';
import 'package:bargainbites/features/homepage/screens/merchant_navbar.dart'; // Add this import for the merchant navbar
import 'package:bargainbites/features/startup/screens/user_type.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add Firestore import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  Future<String?> _getUserType(User user) async {
    // Check 'users' collection by email
    final userQuerySnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .where('email', isEqualTo: user.email)
        .limit(1)
        .get();
    if (userQuerySnapshot.docs.isNotEmpty) {
      return 'user';
    }

    // Check 'merchants' collection by email
    final merchantQuerySnapshot = await FirebaseFirestore.instance
        .collection('Merchants')
        .where('merchantEmail', isEqualTo: user.email)
        .limit(1)
        .get();
    if (merchantQuerySnapshot.docs.isNotEmpty) {
      return 'merchant';
    }

    // User not found in either collection
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // User is not logged in
          if (!snapshot.hasData) {
            return const UserType();
          }

          // User is logged in
          final user = snapshot.data!;
          return FutureBuilder<String?>(
            future: _getUserType(user),
            builder: (context, userTypeSnapshot) {
              if (userTypeSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (userTypeSnapshot.hasError || !userTypeSnapshot.hasData) {
                return const Center(child: Text('Error loading user type'));
              }

              final userType = userTypeSnapshot.data!;
              if (userType == 'user') {
                return const NavBar(); // User's home screen
              } else if (userType == 'merchant') {
                return const MerchantNavbar(); // Merchant's home screen
              } else {
                return const Center(child: Text('Invalid user type'));
              }
            },
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AuthPage(),
    routes: {
      '/userHome': (context) => NavBar(),
      '/merchantHome': (context) => MerchantNavbar(),
    },
  ));
}
