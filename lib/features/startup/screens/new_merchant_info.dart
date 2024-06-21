import 'package:bargainbites/features/startup/screens/user_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/constants/colors.dart';

class NewMerchantInfo extends StatelessWidget {
  const NewMerchantInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 70),
              child: Text(
                'Thank You for Signing Up!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Center(
            child: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: SvgPicture.asset(
                      'assets/images/new_merchant_info_img.svg',
                      width: constraints.maxWidth * 0.7,
                      height: constraints.maxHeight * 0.8,
                      fit: BoxFit.cover,
                    ),
                  );
                }
            )
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                          text: 'Your application has been successfully submitted. We appreciate your interest in partnering with.',
                        ),
                        TextSpan(
                          text: 'Bargain Bites ',
                          style: TextStyle(fontWeight: FontWeight.bold, color: TColors.bBlack),
                        ),
                        TextSpan(
                          text: 'Our team will review your application, and you will receive an update via email within the next 2-3 business days.\n\nFor any urgent queries, feel free to contact our support team at '
                        ),
                        TextSpan(
                          text: 'support@bargainbites.com',
                          style: TextStyle(fontWeight: FontWeight.bold, color: TColors.primaryBtn),
                        ),
                        TextSpan(
                          text: '. We look forward to working with you to reduce food waste and promote sustainability.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserType()));
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
                    'Go To Home',
                    style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Poppins'),
                  ),
                ),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
