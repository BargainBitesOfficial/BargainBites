import 'package:bargainbites/features/authentication/screens/user/signup.dart';
import 'package:flutter/material.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:flutter_svg/svg.dart';

import '../../authentication/screens/user/login.dart';

class OnboardingCustomer extends StatelessWidget {
  const OnboardingCustomer({super.key});

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
          SizedBox(height: 20),
          const Text(
            'Ready For Some Bargains?',
            style: TextStyle(fontSize: 24, color:TColors.primaryText, fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
          ),
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: SvgPicture.asset(
                      'assets/images/onboarding_customer_img.svg',
                      width: constraints.maxWidth * 0.7,
                      height: constraints.maxHeight * 0.8,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),

          ),
          const Text(
            'Already registered on Bargain Bites?',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login()));
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
                'Login to existing account',
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
                'New User?',
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserSignupScreen()));
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
                'Create account',
                style: TextStyle(fontSize: 18, color: TColors.primaryText, fontWeight: FontWeight.w400),
              ),
            ),
          ),
          const SizedBox(height: 20), // Adjust this value as needed
        ],
      ),
    );
  }
}