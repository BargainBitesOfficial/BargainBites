import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/sizes.dart';

import 'package:bargainbites/features/authentication/screens/merchant/signup3.dart';
import 'package:bargainbites/features/authentication/controllers/merchant/merchant_signup_controller.dart';

class MerchantSignupPageTwo extends StatefulWidget {
  final String name;
  final String personalNumber;
  final String email;
  final String password;

  const MerchantSignupPageTwo({
    super.key,
    required this.name,
    required this.personalNumber,
    required this.email,
    required this.password,
  });

  @override
  State<MerchantSignupPageTwo> createState() => _MerchantSignupStatePageTwo();
}

class _MerchantSignupStatePageTwo extends State<MerchantSignupPageTwo> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MerchantSignupController(),
      child: Scaffold(
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
                          /// Store Name
                          const Text('Store Name*',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400)),
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
                                  controller: controller.storeNameController,
                                  decoration: InputDecoration(
                                    hintText: "Enter your Store Name",
                                    hintStyle:
                                    const TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return controller.validateStoreName()
                                        ? null
                                        : "Store name must be longer than 4 characters";
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          /// Store ID
                          const Text('Store ID*',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400)),
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
                                  controller: controller.storeIdController,
                                  decoration: InputDecoration(
                                    hintText: "Enter your Store ID",
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins'),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return controller.validateStoreId()
                                        ? null
                                        : "Invalid Store ID";
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),

                          /// Store Contact Number
                          const Text('Store Contact Number*',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w400)),
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
                                  controller: controller.storeNumberController,
                                  decoration: InputDecoration(
                                    hintText: "Enter your Store Contact Number",
                                    hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins'),
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.grey[200],
                                  ),
                                  autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                                  validator: (value) {
                                    return controller.validateStoreNumber()
                                        ? null
                                        : "Invalid Store Contact Number";
                                  },
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    )),
                Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.1,
                    )),

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
                        onPressed: true //controller.isFormValid
                            ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MerchantAddressPage(
                                  name: widget.name,
                                  personalNumber: widget.personalNumber,
                                  email: widget.email,
                                  password: widget.password,
                                  storeId: controller.storeIdController.text,
                                  storeNumber: controller.storeNumberController.text,
                                  storeName: controller.storeNameController.text,
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
