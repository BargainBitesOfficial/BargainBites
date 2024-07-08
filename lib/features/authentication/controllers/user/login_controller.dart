import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  static Future<bool> signUserIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      return true; // Login successful
    } catch (e) {
      // Handle error (e.g., invalid email or password)
      print('Login failed: $e');
      return false; // Login failed
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
