import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordController {
  static final _auth = FirebaseAuth.instance;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  static Future<User?> sendPasswordResetLink(String email) async {
    try{
        await _auth.sendPasswordResetEmail(email: email);
    }catch (e){
      print(e.toString()); // Dont invoke print in production
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }
}