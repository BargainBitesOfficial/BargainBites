
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/styles/spacing_styles.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/text_strings.dart';
import 'package:bargainbites/features/authentication/controllers/user/signup_controller.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final SignupController _signupController = SignupController();

  @override
  void dispose() {
    _signupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _signupController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
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
                        Consumer<SignupController>(
                          builder: (context, controller, child) {
                            return TextFormField(
                              controller: controller.emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: TColors.backgroundContainerColor,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 12.0),
                              ),
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                return controller.validateEmail()
                                    ? null
                                    : "Invalid email format";
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 30),

                        /// Submit Button
                        SizedBox(
                          width: double.infinity,
                          child: Consumer<SignupController>(
                            builder: (context, controller, child) {
                              return ElevatedButton(
                                onPressed: () {
                                  if (controller.emailController.text.isNotEmpty) {
                                    // Implement email send functionality
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: TColors.primaryBtn,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                  side: BorderSide.none,

                                ),
                                child: const Text('Send Code',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
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
                          color: TColors.primaryBtn,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
