import 'package:bargainbites/features/homepage/screens/profile_page.dart';
import 'package:bargainbites/features/startup/screens/new_merchant_info.dart';
import 'package:bargainbites/features/startup/screens/user_type.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MerchantAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      // Check if the email exists in the Firestore collection
      final querySnapshot = await _firestore
          .collection('Merchants')
          .where('merchantEmail', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isEmpty) {
        // Email does not exist in the database
        print('Email does not exist in the database');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email does not exist in the database')),
        );
        return;
      }

      // Email exists, proceed with sign in
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the merchant's data by email
      final merchantDoc = querySnapshot.docs.first;
      final merchantData = merchantDoc.data();

      print('Merchant logged in successfully');
      print('Merchant Name: ${merchantData['merchantName']}');

      if (merchantData['isValidated'] == true) {
        // Navigate to the validated merchant screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
      } else {
        // Navigate to the new merchant info screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NewMerchantInfo()),
        );
      }
    } catch (e) {
      // Error handling
      print('Error logging in merchant: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging in merchant: $e')),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _auth.signOut();
      print('Merchant signed out successfully');

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UserType()),
      );
    } catch (e) {
      print('Error signing out merchant: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error signing out merchant: $e')),
      );
    }
  }
}
