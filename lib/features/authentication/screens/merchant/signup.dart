import 'package:bargainbites/features/authentication/screens/merchant/signup2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/sizes.dart';
import 'package:bargainbites/utils/validators/validation.dart';
import 'package:bargainbites/features/authentication/controllers/merchant/merchant_signup_controller.dart';

class MerchantSignup extends StatefulWidget {
  const MerchantSignup({super.key});

  @override
  State<MerchantSignup> createState() => _MerchantSignupState();
}

class _MerchantSignupState extends State<MerchantSignup> {
  final MerchantSignupController _signupController = MerchantSignupController();
  bool _obscureText = true;

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Create Merchant Account",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 18),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),

        /// Body
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                /// Form
                Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSections),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Name
                        const Text(
                          'Your Name*',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Consumer<MerchantSignupController>(
                          builder: (context, controller, child) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: controller.nameController,
                                decoration: InputDecoration(
                                  hintText: "Required",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return controller.validateName()
                                      ? null
                                      : "Name must be longer than 4 characters";
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        /// Contact Number
                        const Text(
                          'Contact Number*',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Consumer<MerchantSignupController>(
                          builder: (context, controller, child) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: controller.phoneNumberController,
                                decoration: InputDecoration(
                                  hintText: "Required",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return controller.validatePhoneNumber()
                                      ? null
                                      : "Invalid contact number";
                                },
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 16,
                        ),

                        /// Email
                        const Text(
                          'Email*',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Consumer<MerchantSignupController>(
                          builder: (context, controller, child) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: controller.emailController,
                                decoration: InputDecoration(
                                  hintText: "Required",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: TValidator.validateEmail,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        /// Password
                        const Text(
                          'Password*',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Consumer<MerchantSignupController>(
                          builder: (context, controller, child) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: controller.passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "●●●●●●●●●●",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: TValidator.validatePassword,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),

                        /// Confirm Password
                        const Text(
                          'Confirm Password*',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 8),
                        Consumer<MerchantSignupController>(
                          builder: (context, controller, child) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding:
                              const EdgeInsets.symmetric(horizontal: 10.0),
                              child: TextFormField(
                                controller: controller.confirmPasswordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  hintText: "●●●●●●●●●●",
                                  hintStyle: const TextStyle(color: Colors.grey),
                                  border: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.grey[200],
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  return controller.validatePasswords()
                                      ? null
                                      : "Passwords do not match";
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                /// Terms & Conditions
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'By continuing you agree to our ',
                    style: const TextStyle(
                        color: Colors.grey, fontFamily: 'Poppins'),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Terms & Conditions',
                        style: const TextStyle(color: TColors.primaryBtn),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to terms & conditions screen
                          },
                      ),
                      const TextSpan(
                        text: ' and ',
                        style: TextStyle(
                            color: Colors.grey, fontFamily: 'Poppins'),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: const TextStyle(color: TColors.primaryBtn),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Navigate to privacy policy screen
                          },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                /// Next Page Button
                Consumer<MerchantSignupController>(
                  builder: (context, controller, child) {
                    return SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: true //controller.isFirstSectionValid
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                 MerchantSignupPageTwo(
                                  name: controller
                                    .nameController.text,
                                  personalNumber: controller.phoneNumberController.text,
                                  email: controller
                                      .emailController.text,
                                  password: controller
                                      .passwordController.text,
                                )),
                          );
                        }
                            : null,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primaryBtn,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide.none),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next   ',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontSize: 16),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
