import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginController extends StatelessWidget {
  const LoginController({super.key});

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

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
