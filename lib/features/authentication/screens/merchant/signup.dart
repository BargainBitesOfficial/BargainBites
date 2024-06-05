import 'package:bargainbites/features/authentication/screens/merchant/signup2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/sizes.dart';
import 'package:bargainbites/utils/validators/validation.dart';

class MerchantSignup extends StatefulWidget {
  const MerchantSignup({super.key});

  @override
  State<MerchantSignup> createState() => _MerchantSignupState();
}

class _MerchantSignupState extends State<MerchantSignup> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Create Merchant Account",
            style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 18)),
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
                    const Text('Your Name*',
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
                      child: TextFormField(
                        // controller: , Controller Required here
                        decoration: InputDecoration(
                          hintText: "Required",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),

                        /// Validation for name required
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: TValidator.validateEmail,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Contact Number
                    const Text('Contact Number*',
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
                      child: TextFormField(
                        // controller: , Controller Required here
                        decoration: InputDecoration(
                          hintText: "Required",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),

                        /// Validation for name required
                        // autovalidateMode: AutovalidateMode.onUserInteraction,
                        // validator: TValidator.validateEmail,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    /// Email
                    const Text('Email*',
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
                      child: TextFormField(
                        // Controller Required here
                        // controller: LoginController.emailController,
                        decoration: InputDecoration(
                          hintText: "Required",
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: TValidator.validateEmail,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Password
                    const Text('Password*',
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
                      child: TextFormField(
                        /// Controller Required here
                        // controller: LoginController.passwordController,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: TValidator.validatePassword,
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Confirm Password
                    const Text('Confirm Password*',
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
                      child: TextFormField(
                        /// Controller required here
                        // controller: LoginController.passwordController,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: TValidator.validatePassword,
                      ),
                    ),
                  ],
                ),
              )),

              /// Divider
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                      indent: 10,
                      endIndent: 5,
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        fontSize: 14),
                  ),
                  Flexible(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                      indent: 5,
                      endIndent: 10,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Footer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        /// Function will change here
                        // AuthService().signInWithGoogle();
                      },
                      icon: const SizedBox(
                          width: 20,
                          height: 20,
                          child: Image(
                            image: AssetImage("assets/logos/google_icon.png"),
                            width: 40,
                            height: 40,
                          )),
                      label: const Text(
                        'Sign up with Google',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Terms & Conditions
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By continuing you agree to our ',
                  style: const TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Terms & Conditions',
                      style: const TextStyle(color: TColors.primaryBtn),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        // Navigate to terms & conditions screen
                      },
                    ),
                    const TextSpan(
                      text: ' and ',
                      style: TextStyle(color: Colors.grey, fontFamily: 'Poppins'),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: const TextStyle(color: TColors.primaryBtn),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        // Navigate to privacy policy screen
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              /// Next Page Button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantSignupPageTwo()));
                  },
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
                        style: TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 16),
                      ),
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16,),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ),
    );
  }
}
