import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginController extends StatelessWidget {
  const LoginController({super.key});

  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();

  static void signUserIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
