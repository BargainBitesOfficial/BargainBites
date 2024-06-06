import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/utils/constants/sizes.dart';
import 'package:bargainbites/utils/helpers/helper_functions.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:flutter/services.dart';
import 'package:bargainbites/features/authentication/controllers/user/signup_controller.dart';
import 'package:bargainbites/features/authentication/models/signup_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'login.dart';



class SignupAddress extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const SignupAddress({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  _SignupAddressState createState() => _SignupAddressState();
}

class _SignupAddressState extends State<SignupAddress> {
  final TextEditingController countryController =
      TextEditingController(text: 'Canada');
  final TextEditingController postalCodeController = TextEditingController();

  @override
  void dispose() {
    countryController.dispose();
    postalCodeController.dispose();
    super.dispose();
  }

  // Future<void> submit() async {
  //   final signupModel = SignupModel(
  //     name: widget.name,
  //     email: widget.email,
  //     password: widget.password,
  //     country: countryController.text,
  //     postalCode: postalCodeController.text,
  //   );
  //
  //   final signupController = Provider.of<SignupController>(context, listen: false);
  //   try {
  //     await signupController.createUser(signupModel);
  //
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("User created successfully."),
  //         backgroundColor: Colors.green,
  //       ),
  //     );
  //
  //     signupController.reset();
  //     Navigator.popUntil(context, (route) => route.isFirst);
  //   } on FirebaseAuthException catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text("Failed to create user: ${e.message}"),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   }
  // }

  void submit() async {
    final signupModel = SignupModel(
      name: widget.name,
      email: widget.email,
      password: widget.password,
      country: countryController.text,
      postalCode: postalCodeController.text,
    );

    final signupController = Provider.of<SignupController>(context, listen: false);

    try {
      await signupController.createUser(signupModel);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("User created successfully."),
          backgroundColor: Colors.green,
        ),
      );

      signupController.reset();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Login()),
        (Route<dynamic> route) => false,
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed to create user: ${e.message}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Account",
            style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Center(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double size = constraints.maxWidth * 0.7; // Scale to 50% of the parent's width
                    return Container(
                      width: size,
                      height: size,
                      child: SvgPicture.asset(
                        'assets/images/signup_address.svg', // Ensure this path matches your SVG asset
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
              Form(
                child: Column(
                  children: [
                    // Country
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Country',
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
                          child: TextFormField(
                            controller: countryController,
                            readOnly: true,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              filled: true,
                              fillColor: TColors.backgroundContainerColor,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              //prefixIcon: const Icon(Icons.location_city),
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    // Postal Code
                    Container(
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Postal Code',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: postalCodeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: TColors.backgroundContainerColor,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        prefixIcon: const Icon(Icons.pin_drop),
                      ),
                      maxLength: 6,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z0-9]')),
                      ],
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 100),
                    // Next Page
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: submit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          side: BorderSide.none,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Sign Me Up',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
