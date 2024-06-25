import 'package:bargainbites/features/authentication/screens/user/login.dart';
import 'package:bargainbites/features/homepage/screens/navbar.dart';
import 'package:bargainbites/features/startup/screens/user_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData) {
            return const NavBar();
          }
          // user is not logged in
          else {
            return const UserType();
          }
        },
      ),
    );
  }
}
