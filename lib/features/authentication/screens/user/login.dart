import 'package:bargainbites/features/authentication/controllers/auth_service.dart';
import 'package:bargainbites/features/homepage/screens/navbar.dart';
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
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  String? _emailError;
  String? _passwordError;
  bool _emailValidated = false;
  bool _passwordValidated = false;

  void _validateEmail() {
    setState(() {
      _emailError = TValidator.validateEmail(LoginController.emailController.text);
      _emailValidated = _emailError == null;
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordError = TValidator.validatePassword(LoginController.passwordController.text);
      _passwordValidated = _passwordError == null;
    });
  }

  bool get _isFormValid => _emailValidated && _passwordValidated;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
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
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                        child: TextFormField(
                          controller: LoginController.emailController,
                          decoration: InputDecoration(
                            hintText: "Required",
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (_) => _validateEmail(),
                        ),
                      ),
                      if (_emailError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _emailError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      const SizedBox(height: 16),
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
                          onChanged: (_) => _validatePassword(),
                        ),
                      ),
                      if (_passwordError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            _passwordError!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
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
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isFormValid
                              ? () async {
                            if (_formKey.currentState!.validate()) {
                              bool success =
                              await LoginController.signUserIn();
                              if (success) {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavBar()),
                                      (Route<dynamic> route) => false,
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: TColors.primary,
                                      content: Text(
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              color: Colors.white),
                                          'Login failed. Please try again.')),
                                );
                              }
                            }
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: _isFormValid
                                  ? TColors.primaryBtn
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              side: BorderSide.none),
                          child: const Text(
                            TTexts.login,
                            style: TextStyle(
                                fontFamily: 'Poppins', color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
                      onPressed: () async {
                        bool success = await AuthService().signInWithGoogle();
                        if (success) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NavBar()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: TColors.primary,
                                content: Text(
                                    style: TextStyle(
                                        fontFamily: "Poppins",
                                        color: Colors.white),
                                    'Google sign-in failed. Please try again.')),
                          );
                        }
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
