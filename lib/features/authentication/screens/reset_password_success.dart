import 'package:bargainbites/common/styles/spacing_styles.dart';
//import 'package:bargainbites/features/authentication/screens/user/login.dart'
import 'package:bargainbites/features/authentication/controllers/user/login_controller.dart';
import 'package:bargainbites/utils/constants/colors.dart';
import 'package:bargainbites/utils/constants/text_strings.dart';
import 'package:bargainbites/utils/constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class ResetPasswordSuccess extends StatelessWidget {
  const ResetPasswordSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              // Success Image Placeholder
              SizedBox(
                width: 160,
                height: 160,
                child: SvgPicture.asset(
                  "assets/images/success_img.svg", // Replace with your image asset
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 20),
              // Success Message
              Text(
                'Password Updated Successfully',
                style: TextStyles.heading(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // Subtext
              Text(
                'Password changed successfully',
                style: TextStyles.regulartext(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              Text(
                'you can login again with the new password',
                style: TextStyles.regulartext(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Back to Home Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    LoginController.signUserIn();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TColors.primaryBtn,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    side: BorderSide.none,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        TTexts.backToHome,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 10),
                      FaIcon(
                        FontAwesomeIcons.chevronRight,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

