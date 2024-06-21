import 'package:flutter/material.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:flutter_svg/svg.dart';

import '../../authentication/screens/merchant/merchant_login.dart';
import '../../authentication/screens/merchant/signup.dart';

class OnboardingMerchant extends StatelessWidget {
  const OnboardingMerchant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(

              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Poppins',
                color: TColors.bBlack,
              ),
              children: [
                TextSpan(
                    text: 'Tired of throwing away unsold/expired items?',
                    style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w400)
                ),
                TextSpan(
                  text: ' Join BargainBites',
                  style: TextStyle(fontSize:20, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: TColors.primaryText),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: SvgPicture.asset(
                      'assets/images/onboarding_merchant_img.svg',
                      width: constraints.maxWidth * 0.7,
                      height: constraints.maxHeight * 0.7,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),

          ),
          const Text(
            'Already a partner with Bargain Bites?',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantLogin()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: TColors.primaryBtn,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Login to merchant account',
                style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Divider(
                  thickness: 1,
                  indent: 50,
                  endIndent: 8,
                ),
              ),
              Text(
                'Or Partner Now',
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400),
              ),
              Expanded(
                child: Divider(
                  thickness: 1,
                  indent: 8,
                  endIndent: 50,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 15),
            child: OutlinedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MerchantSignup()));
                // Implement your account creation functionality here
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
                side: const BorderSide(color: TColors.primary, width: 1.8),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Create a merchant account',
                style: TextStyle(fontSize: 18, color: TColors.primaryText),
              ),
            ),
          ),
          const SizedBox(height: 20), // Adjust this value as needed
        ],
      ),
    );
  }
}