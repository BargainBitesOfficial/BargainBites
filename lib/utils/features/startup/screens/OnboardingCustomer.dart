import 'package:flutter/material.dart';
import 'package:bargainbites/utils/constants/colors.dart';

class Onboardingcustomer extends StatelessWidget {
  const Onboardingcustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Implement your back button functionality here
          },
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Container(
                width: 250,
                height: 250,
                color: Colors.grey[300], // Placeholder for the image
                child: Icon(
                  Icons.image,
                  size: 100,
                  color: Colors.grey[400],
                ),
              ),
            ),

          ),
          const Text(
            'Already registered on Bargain Bites?',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 0, 24, 10),
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
                'Login to existing account',
                style: TextStyle(fontSize: 15, color: Colors.white, fontFamily: 'Poppins'),
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
                // Implement your account creation functionality here
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(vertical: 13),
                side: const BorderSide(color: Colors.black),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Create account',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ),
          const SizedBox(height: 20), // Adjust this value as needed
        ],
      ),
    );
  }
}