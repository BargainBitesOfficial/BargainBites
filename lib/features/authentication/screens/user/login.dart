import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:bargainbites/common/styles/spacing_styles.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/sizes.dart';
import 'package:bargainbites/utils/constants/text_strings.dart';
import 'package:bargainbites/features/authentication/controllers/user/login.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  final bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Login", style: TextStyle(
            fontSize: 25, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
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
            children: [
              const Text(
                TTexts.loginSubTitle,
                style: TextStyle(fontSize: 30,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    color: TColors.buttonPrimary),
              ),

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
                          style: TextStyle(fontSize: 16,
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
                          controller: LoginController.emailController,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.email),
                            hintText: "Required",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      /// Password
                      const Text('Password',
                          style: TextStyle(fontSize: 16, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: LoginController.passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.password),
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
                                // setState(() {
                                //   _obscureText = !_obscureText;
                                // });
                              },
                            ),
                          ),
                        ),
                      ),

                      /// Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(TTexts.forgetPassword),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            LoginController.signUserIn();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.buttonPrimary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide.none
                          ),
                          child: const Text(TTexts.login),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Divider
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Divider(
                      color: Colors.grey,
                      thickness: 0.8,
                      indent: 10,
                      endIndent: 5,
                    ),
                  ),
                  Text(
                    TTexts.orLoginUsing.capitalize!,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelLarge,
                  ),
                  const Flexible(
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
                      onPressed: () {},
                      icon: const SizedBox(
                          width: 14,
                          height: 14,
                          child: Image(
                            image: AssetImage("assets/logos/google_icon.png"),
                            width: 40,
                            height: 40,
                          )),
                      label: const Text(
                        'Sign in with Google',
                        style: TextStyle(color: Colors.black,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            fontSize: 16),
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
