import 'package:flutter/material.dart';
import 'package:bargainbites/common/styles/spacing_styles.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/sizes.dart';
import 'package:bargainbites/utils/constants/text_strings.dart';
import 'package:bargainbites/features/authentication/controllers/merchant/merchant_login_controller.dart';
import 'package:bargainbites/utils/validators/validation.dart';

import '../forgot_password.dart';

class MerchantLogin extends StatefulWidget {
  const MerchantLogin({super.key});

  @override
  State<MerchantLogin> createState() => _MerchantLoginState();
}

class _MerchantLoginState extends State<MerchantLogin> {
  final MerchantAuthController _authController = MerchantAuthController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  String? _emailError;
  String? _passwordError;
  bool _emailValidated = false;
  bool _passwordValidated = false;

  void _validateEmail() {
    setState(() {
      _emailError = TValidator.validateEmail(_emailController.text);
      _emailValidated = _emailError == null;
    });
  }

  void _validatePassword() {
    setState(() {
      _passwordError = TValidator.validatePassword(_passwordController.text);
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
        title: const Text(
          "Login",
          style: TextStyle(
              fontSize: 25, fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
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
                TTexts.merchantAccess,
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    color: TColors.primaryBtn),
              ),
              Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: TSizes.spaceBtwSections),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email',
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _emailController,
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
                      const Text(
                        'Password',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextFormField(
                          controller: _passwordController,
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
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 8),
                            ),
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
                                color: TColors.primaryBtn,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isFormValid
                              ? () {
                            final email = _emailController.text;
                            final password = _passwordController.text;
                            _authController.signIn(email, password, context);
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFormValid
                                ? TColors.primaryBtn
                                : Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide.none,
                          ),
                          child: const Text(
                            TTexts.login,
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Poppins"),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
