import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';

class NewMerchantInfo extends StatelessWidget {
  const NewMerchantInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 90),
            const Text(
              'Thank You for Signing Up!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 60),
            const Icon(
              Icons.check_circle,
              color: TColors.primaryBtn,
              size: 125,
            ),
            const SizedBox(height: 90),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: RichText(
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
              )
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Implement your login functionality here
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
                  'Log out',
                  style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Poppins'),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
