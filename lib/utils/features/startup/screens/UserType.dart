import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class UserType extends StatelessWidget {
  const UserType({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
            'Select one to get started',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 26),
            child: const Text(
            'I am a....',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: TColors.greyText),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 10),
            child: ElevatedButton.icon(
              onPressed: () {
              // Add your onPressed code here!
              },
              icon: const Icon(Icons.store),
              label: const Text('Merchant', style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400, letterSpacing: 1),),
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
            padding: const EdgeInsets.fromLTRB(24, 10, 24, 15),
            child: ElevatedButton.icon(
              onPressed: () {
                // Add your onPressed code here!
              },
              icon: const Icon(Icons.shopping_bag),
              label: const Text('Customer',style: TextStyle(fontSize: 16, fontFamily: 'Poppins', fontWeight: FontWeight.w400, letterSpacing: 1)),
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
          const SizedBox(height: 20), // Adjust this value as needed
        ],
      ),
    );
  }
}
