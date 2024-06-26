import 'package:bargainbites/features/startup/screens/onboarding_customer.dart';
import 'package:bargainbites/features/startup/screens/onboarding_merchant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/constants/colors.dart';
class UserType extends StatelessWidget {
  const UserType({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: SvgPicture.asset(
                      'assets/images/welcome_img.svg',
                      width: constraints.maxWidth * 0.8,
                      height: constraints.maxHeight * 0.8,
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),

          ),
          const Text(
            'Select one to get started',
            style: TextStyle(fontSize: 16, fontFamily: "Poppins"),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 26),
            child: const Text(
            'I am a....',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: TColors.greyText, fontFamily: "Poppins"),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 15),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnboardingCustomer()));
              },
              icon: const Icon(Icons.shopping_bag,color:TColors.bWhite),
              label: const Text('Customer',style: TextStyle(color:TColors.bWhite ,fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400, letterSpacing: 1)),
              style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primaryBtn,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  side: BorderSide.none
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
                'Or',
                style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400, letterSpacing: 1)),
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
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OnboardingMerchant()));
              },
              icon: const Icon(Icons.store,color:TColors.bWhite),
              label: const Text('Merchant', style: TextStyle(color:TColors.bWhite,fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400, letterSpacing: 1),),
              style: ElevatedButton.styleFrom(
                  backgroundColor: TColors.primaryBtn,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),

                  ),
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  side: BorderSide.none
              ),

            ),
          ),
          const SizedBox(height: 20), // Adjust this value as needed
        ],
      ),
    );
  }
}
