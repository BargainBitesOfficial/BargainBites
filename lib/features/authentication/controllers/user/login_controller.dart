import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:bargainbites/features/homepage/screens/homepage.dart';

class LoginController {
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  static Future<void> signIn(BuildContext context) async {
    try {
      if (emailController.text.isEmpty || !emailController.text.contains('@')) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter a valid email address'))
        );
        return;
      }

      if (passwordController.text.isEmpty || passwordController.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password must be at least 6 characters'))
        );
        return;
      }

      // Sign in the merchant with email and password using Firebase Authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );

      // Get the merchant's additional data from Firestore
      final currentUser = FirebaseAuth.instance.currentUser;
      final userDoc = await FirebaseFirestore.instance.collection('Users').doc(currentUser?.uid).get();
      final userData = userDoc.data();
      if (userData != null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User logged in successfully'))
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Homepage()), // Change to the appropriate login screen if needed
              (Route<dynamic> route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('User data not found'))
        );
      }
    } catch (e) {
      // Error handling
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging in User: $e'))
      );
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User signed out successfully'))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error signing out User: $e'))
      );
    }
  }
}
