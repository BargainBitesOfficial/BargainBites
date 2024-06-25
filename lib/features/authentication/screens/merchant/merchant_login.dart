import 'package:flutter/material.dart';

import 'package:bargainbites/common/styles/spacing_styles.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/sizes.dart';
import 'package:bargainbites/utils/constants/text_strings.dart';

class MerchantLogin extends StatelessWidget {
  const MerchantLogin({super.key});

  final bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Login", style: TextStyle(fontSize: 25, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
                TTexts.merchantAccess,
                style: TextStyle(fontSize: 24, fontFamily: "Poppins", fontWeight: FontWeight.w400, color: TColors.primaryBtn),
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
                          style: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: "Poppins", fontWeight: FontWeight.w400)),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: TextField(
                          decoration: InputDecoration(
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
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            ),
                            onPressed: () {
                              // Implement forgot password functionality
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

                      /// Sign In Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: TColors.primaryBtn,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            side: BorderSide.none,
                          ),
                          child: const Text(TTexts.login, style: TextStyle(color: Colors.white, fontFamily: "Poppins"),),
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
