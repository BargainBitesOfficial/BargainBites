import 'package:flutter/material.dart';
import 'package:bargainbites/utils/constants/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: TColors.linerGradient,
        ),

        child:  Column(
          children: [
             Container(
               height: 191,
               width: 275,
               margin: const EdgeInsets.only(top: 260),
               decoration: const BoxDecoration(
                 image: DecorationImage(
                   fit: BoxFit.fill,
                     image:  AssetImage('assets/logos/app_logo_275_191.png')
                 )

               ),
             ),
             const Center(
              child:  Text('BargainBites',
                style: TextStyle(
                  fontSize: 40,
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Center(
              child:  Text('Save food, save money!',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}