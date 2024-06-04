import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/styles/spacing_styles.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _email = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _email.text.trim());

      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Password reset link sent! Check your email!"),
            );
          });

    } on FirebaseAuthException catch (e) {
      print(e);    // Dont use print in production
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Implement back functionality
          },
        ),
        centerTitle: true,
      ),

      /// Body
      body: Padding(
        padding: TSpacingStyle.paddingWithAppBarHeight,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Forgot Password?",
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 15), // Increased spacing
              const Text(
                "Don’t worry! It happens. Please enter the email associated with your account.",
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    color: Colors.grey),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 15),

              /// Form
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Email
                      const Text('Email',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: "Required",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      /// Submit Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: passwordReset,
                          // onPressed: () async {
                          //     // await ForgotPasswordController.sendPasswordResetLink(_email.text);
                          // },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.buttonPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide.none,
                          ),
                          child: const Text('Send Code'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30), // Increased spacing

              /// Remember password? Log in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Remember password? ",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w400,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Implement navigation to login screen
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w700,
                        color: TColors.buttonPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
