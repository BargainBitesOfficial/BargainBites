import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bargainbites/features/authentication/models/signup_model.dart';
import 'package:bargainbites/features/authentication/screens/user/signup_address.dart';

class SignupController extends ChangeNotifier {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isNameValid = false;
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isConfirmPasswordValid = false;

  SignupController() {
    nameController.addListener(_validateName);
    emailController.addListener(_validateEmail);
    passwordController.addListener(_validatePasswords);
    confirmPasswordController.addListener(_validatePasswords);
  }

  bool get isFormValid =>
      _isNameValid &&
      _isEmailValid &&
      _isPasswordValid &&
      _isConfirmPasswordValid;

  void _validateName() {
    _isNameValid = validateName();
    notifyListeners();
  }

  void _validateEmail() {
    _isEmailValid = validateEmail();
    notifyListeners();
  }

  void _validatePasswords() {
    _isPasswordValid = passwordController.text.isNotEmpty;
    _isConfirmPasswordValid = validatePasswords();
    notifyListeners();
  }

  bool validateEmail() {
    String email = emailController.text;
    RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  bool validateName() {
    String name = nameController.text;
    RegExp nameRegex = RegExp(r'^[a-zA-Z\s]+$');
    return name.length > 4 && nameRegex.hasMatch(name);
  }

  bool validatePasswords() {
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;
    return password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword;
  }

  Future<void> createUser(SignupModel signupModel) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: signupModel.email,
        password: signupModel.password,
      );

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set({
        'name': signupModel.name,
        'email': signupModel.email,
        'country': signupModel.country,
        'postalCode': signupModel.postalCode,
      });

      reset();
    } on FirebaseAuthException catch (e) {
      print('Error: $e'); // Dont invoke print in production code
    }
  }

  void reset() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    _isNameValid = false;
    _isEmailValid = false;
    _isPasswordValid = false;
    _isConfirmPasswordValid = false;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void submitForm(BuildContext context) {
    if (!validateName()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Name must be longer than 4 characters."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!validateEmail()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Invalid email format. Please enter a valid email."),
          backgroundColor: Colors.red,
        ),
      );
    } else if (!validatePasswords()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("The passwords do not match. Please try again."),
          backgroundColor: Colors.red,
        ),
      );
    }
    // else {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(
    //       content: Text("Form submission successful."),
    //       backgroundColor: Colors.green,
    //     ),
    //   );
    // }
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupAddress(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          ),
        ),
      );
    }
  }
}
