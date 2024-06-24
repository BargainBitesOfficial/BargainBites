import 'package:firebase_auth/firebase_auth.dart';


import 'package:cloud_firestore/cloud_firestore.dart';

// class MerchantLoginController extends StatelessWidget {
//   const MerchantLoginController({super.key});
//
//   static final emailController = TextEditingController();
//   static final passwordController = TextEditingController();
//
//   static void signMerchantIn() async {
//     await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: emailController.text, password: passwordController.text);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }





//------------------------------------------------------------------------------


class MerchantAuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signIn(String email, String password) async {
    try {
      // Sign in the merchant with email and password using Firebase Authentication
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the merchant's additional data from Firestore
      final currentUser = _auth.currentUser;
      final merchantDoc =
      await _firestore.collection('Merchants').doc(currentUser?.uid).get();

      // Example: You can access merchant data like this
      final merchantData = merchantDoc.data();
      if (merchantData != null)
      {
        print('Merchant logged in successfully');
        print('Merchant Name: ${merchantData['name']}');
        // You can access other merchant data here
      } else {
        print('Merchant data not found');
        // Handle the case when merchant data is not found in Firestore
      }
    } catch (e) {
      // Error handling
      print('Error logging in merchant: $e');
      // You can also throw an exception here or handle the error UI accordingly
    }
  }

  Future<void> signOut() async {
    try {
      // Sign out the current merchant
      await _auth.signOut();

      // Merchant signed out successfully
      print('Merchant signed out successfully');
    } catch (e) {
      // Error handling
      print('Error signing out merchant: $e');
      // You can also throw an exception here or handle the error UI accordingly
    }
  }
}

