import 'package:bargainbites/utils/constants/sizes.dart';
import 'package:bargainbites/features/authentication/screens/user/signup_address.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bargainbites/features/authentication/controllers/user/signup_controller.dart';
import 'package:provider/provider.dart';

class UserSignupScreen extends StatefulWidget {
  const UserSignupScreen({super.key});

  @override
  _UserSignupScreenState createState() => _UserSignupScreenState();
}

class _UserSignupScreenState extends State<UserSignupScreen> {
  final SignupController _signupController = SignupController();

  @override
  void dispose() {
    _signupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final dark = THelperFunctions.isDarkMode(context);

    return ChangeNotifierProvider(
      create: (_) => _signupController,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Create Your Account",
              style: TextStyle(
                  fontFamily: "Poppins", fontWeight: FontWeight.w700)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {},
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                const SizedBox(height: TSizes.spaceBtwSections),
                Form(
                  child: Column(
                    children: [
                      // Name
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Consumer<SignupController>(
                              builder: (context, controller, child) {
                                return TextFormField(
                                  controller: controller.nameController,
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
                                    return controller.validateName()
                                        ? null
                                        : "Name must be longer than 4 characters";
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp(r'[a-zA-Z]'),
                                    ),
                                  ],
                                  keyboardType: TextInputType.text,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      // Email
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
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
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      // Password
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Consumer<SignupController>(
                        builder: (context, controller, child) {
                          return TextFormField(
                            obscureText: true,
                            controller: controller.passwordController,
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
                              return value != null && value.isNotEmpty
                                  ? value.length < 8
                                      ? "Password Cannot be Less than 8"
                                      : null
                                  : "Password cannot be empty";
                            },
                          );
                        },
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                      // Confirm Password
                      Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Consumer<SignupController>(
                        builder: (context, controller, child) {
                          return TextFormField(
                            obscureText: true,
                            controller: controller.confirmPasswordController,
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
                              return controller.validatePasswords()
                                  ? null
                                  : "Passwords do not match";
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 100),
                      // Terms & Conditions Checkbox
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'By continuing you agree to our ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                    text: 'Terms of Use ',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(
                                          color: Colors.green,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                  TextSpan(
                                    text: 'and ',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy.',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(
                                          color: Colors.green,
                                          decoration: TextDecoration.underline,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.defaultSpace),
                      // Next Page Button
                      Consumer<SignupController>(
                        builder: (context, controller, child) {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: controller.isFormValid
                                  ? () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignupAddress(
                                                  name: controller
                                                      .nameController.text,
                                                  email: controller
                                                      .emailController.text,
                                                  password: controller
                                                      .passwordController.text,
                                                )),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                minimumSize: const Size(double.infinity, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 13),
                                side: BorderSide.none,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      letterSpacing: 1,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  // Adjust the width as needed
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
