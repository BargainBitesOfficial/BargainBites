import 'package:bargainbites/features/authentication/controllers/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bargainbites/common/styles/spacing_styles.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/sizes.dart';
import 'package:bargainbites/utils/constants/text_strings.dart';
import 'package:bargainbites/features/authentication/controllers/user/login_controller.dart';
import 'package:bargainbites/utils/validators/validation.dart';
import 'package:bargainbites/features/authentication/screens/forgot_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Login",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Implement back functionality
            Navigator.pop(context);
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
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    color: TColors.primaryBtn),
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
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: TextFormField(
                              controller: LoginController.emailController,
                              decoration: InputDecoration(
                                icon: const Icon(Icons.email),
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
                          const SizedBox(height: 5.0), // Add space between text field and error message
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0), // Adjust left padding as needed
                            child: Text(
                              LoginController.emailController.text.isNotEmpty ? TValidator.validateEmail(LoginController.emailController.text) ?? '' : '',
                              style: const TextStyle(color: Colors.red)
                              ,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      /// Password
                      const Text('Password',
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
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),
                          ),
                          // autovalidateMode: AutovalidateMode.onUserInteraction,
                          // validator: TValidator.validatePassword,
                        ),
                      ),

                      /// Forgot Password
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPassword()));
                            },
                            child: const Text(
                              TTexts.forgetPassword,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      /// Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            LoginController.signIn(context);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primaryBtn,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side: BorderSide.none),
                          child: const Text(TTexts.login, style: TextStyle(fontFamily: 'Poppins', color: Colors.white),),
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
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w400,
                        fontSize: 12),
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
                      onPressed: () {
                        AuthService().signInWithGoogle();
                      },
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
            ],
          ),
        ),
      ),
    );
  }
}
